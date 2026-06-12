//
//  ApiClient.swift
//  ChatApp
//
//  Created by Houleng Ly on 7/6/26.
//

//
//  APIClient.swift
//  SwiftUIApp
//
//  Created by Houleng Ly on 21/2/26.
//

import Foundation
import Alamofire
import EasyLogger

enum APIError: Error, LocalizedError {
    case invalidURL
    case notFound
    case serverError(Int)
    case serverMessage(String)
    case decodingFailed(Error)
    case networkUnavailable
    case timeout
    case unknown(Error)

    var errorDescription: String? {
        switch self {
        case .invalidURL:               return "Invalid URL."
        case .notFound:                 return "The requested resource was not found."
        case .serverError(let code):    return "Server error occurred. (Code: \(code))"
        case .serverMessage(let msg):   return msg  // 👈 Add this
        case .decodingFailed(let e):    return "Failed to decode response: \(e.localizedDescription)"
        case .networkUnavailable:       return "No internet connection."
        case .timeout:                  return "The request timed out."
        case .unknown(let e):           return e.localizedDescription
        }
    }
    static func map(from afError: AFError, statusCode: Int?, data: Data?) -> APIError {
        
        // 👇 Try to parse message from server response body
        if let data = data,
           let json = try? JSONDecoder().decode(ServerErrorResponse.self, from: data) {
            return .serverMessage(json.message)
        }

        if case .responseSerializationFailed(let reason) = afError,
           case .decodingFailed(let error) = reason {
            return .decodingFailed(error)
        }

        if let urlError = afError.underlyingError as? URLError {
            switch urlError.code {
            case .timedOut:               return .timeout
            case .notConnectedToInternet: return .networkUnavailable
            default: break
            }
        }

        switch statusCode {
        case 404:                         return .notFound
        case let code? where code >= 500: return .serverError(code)
        default:                          return .unknown(afError)
        }
    }

    struct ServerErrorResponse: Codable {
        let message: String
    }
}


final class APIInterceptor: RequestInterceptor {

    // MARK: Adapt — modify request before sending (e.g. inject headers)

    func adapt(
        _ urlRequest: URLRequest,
        for session: Session,
        completion: @escaping (Result<URLRequest, Error>) -> Void
    ) {
        // TODO: Add request modifications here if needed
        completion(.success(urlRequest))
    }

    func retry(
        _ request: Request,
        for session: Session,
        dueTo error: Error,
        completion: @escaping (RetryResult) -> Void
    ) {
        // TODO: Add retry logic here if needed
        completion(.doNotRetry)
    }
}

// MARK: - Response Logger (EventMonitor)

final class ResponseLogger: EventMonitor {
    let queue = DispatchQueue(label: "com.swiftuiapp.logger", qos: .background)

    func requestDidResume(_ request: Request) {
//        print("""
//        \n➡️ [REQUEST]
//           Method  : \(request.request?.httpMethod ?? "Unknown")
//           URL     : \(request.request?.url?.absoluteString ?? "Unknown")
//           Headers : \(request.request?.headers ?? [:])
//        """)
//        if let body = request.request?.httpBody,
//           let bodyStr = String(data: body, encoding: .utf8) {
//            print("   Body    : \(bodyStr)")
//        }
    }

    @MainActor func request<Value>(
        _ request: DataRequest,
        didParseResponse response: DataResponse<Value, AFError>
    ) {
        let statusCode = response.response?.statusCode ?? 0
        let emoji      = (200..<300).contains(statusCode) ? "✅" : "❌"
        let duration   = String(format: "%.3f", response.metrics?.taskInterval.duration ?? 0)
        EasyLogger.shared.debug("""
        \n\(emoji) [RESPONSE]
           URL     : \(request.request?.url?.absoluteString ?? "Unknown")
           Status  : \(statusCode)
           Duration: \(duration)s
        """)

//        if let data = response.data,
//           let json = try? JSONSerialization.jsonObject(with: data),
//           let pretty = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted),
//           let prettyStr = String(data: pretty, encoding: .utf8) {
//            print("   Body    :\n\(prettyStr)")
//        }

        if let error = response.error {
            print("   Error   : \(error.localizedDescription)")
        }
    }
    
    
}

// MARK: - APIClient

final class APIClient {

    // MARK: Singleton

    static let shared = APIClient()

    // MARK: Properties

    private let session: Session
    private let baseURL: String

    // MARK: Init

    private init(baseURL: String = "AppConfig.baseURL") {
        self.baseURL = baseURL

        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest  = 30
        configuration.timeoutIntervalForResource = 60

        self.session = Session(
            configuration: configuration,
            interceptor: APIInterceptor(),
            eventMonitors: [ResponseLogger()]
        )
    }

   

    func request<T: Decodable>(
        _ endpoint: Endpoint,
        decoder: JSONDecoder = .default
    ) async throws -> T {
        
        let url = baseURL + endpoint.path

        let dataTask = session.request(
            url,
            method: endpoint.method,
            parameters: endpoint.parameters,
            encoding: endpoint.encoding,
            headers: endpoint.headers
        )
        .validate()
        .serializingDecodable(T.self, decoder: decoder)

        do {
            return try await dataTask.value
        } catch let afError as AFError {
            let response = await dataTask.response
            let statusCode = response.response?.statusCode
            let data = response.data  // 👈 grab raw response body
            throw APIError.map(from: afError, statusCode: statusCode, data: data)
        } catch {
            throw APIError.unknown(error)
        }
    }

    // MARK: - Multipart Upload

//    func upload<T: Decodable>(
//        _ endpoint: Endpoint,
//        multipartBuilder: @escaping (MultipartFormData) -> Void,
//        decoder: JSONDecoder = .default
//    ) async throws -> T {
//
//        let url = baseURL + endpoint.path
//
//        return try await withCheckedThrowingContinuation { continuation in
//            session.upload(
//                multipartFormData: multipartBuilder,
//                to: url,
//                method: endpoint.method,
//                headers: endpoint.headers
//            )
//            .validate()
//            .responseDecodable(of: T.self, decoder: decoder) { response in
//                switch response.result {
//                case .success(let value):
//                    continuation.resume(returning: value)
//                case .failure(let error):
//                    let statusCode = response.response?.statusCode
//                    continuation.resume(throwing: APIError.map(from: error, statusCode: statusCode))
//                }
//            }
//        }
//    }


    func download(
        from urlString: String,
        to destination: DownloadRequest.Destination? = nil
    ) async throws -> URL {
        return try await withCheckedThrowingContinuation { continuation in
            session.download(urlString, to: destination)
                .validate()
                .responseURL { response in
                    switch response.result {
                    case .success(let url):
                        continuation.resume(returning: url)
                    case .failure(let error):
                        continuation.resume(throwing: APIError.unknown(error))
                    }
                }
        }
    }
}

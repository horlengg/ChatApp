//
//  Endpoint.swift
//  ChatApp
//
//  Created by Houleng Ly on 7/6/26.
//


import Alamofire


protocol Endpoint {
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var parameters: Parameters? { get }
    var encoding: ParameterEncoding { get }
}

extension Endpoint {
    var headers: HTTPHeaders? { nil }
    var parameters: Parameters? { nil }
    var encoding: ParameterEncoding {
        method == .get ? URLEncoding.default : JSONEncoding.default
    }
}



enum ProductEndpoint: Endpoint {
    
    case list
    case detail(id: Int)
    case create(title: String, body: String)
    case update(id: Int, title: String)
    case delete(id: Int)

    var path: String {
        switch self {
        case .list:              return "/products"
        case .detail(let id):    return "/products/\(id)"
        case .create:            return "/products"
        case .update(let id, _): return "/products/\(id)"
        case .delete(let id):    return "/products/\(id)"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .list, .detail: return .get
        case .create:        return .post
        case .update:        return .put
        case .delete:        return .delete
        }
    }

    var parameters: Parameters? {
        switch self {
        case .create(let title, let body):
            return ["title": title, "body": body]
        case .update(_, let title):
            return ["title": title]
        default:
            return nil
        }
    }
}

enum PostEndpoint: Endpoint {
    case list(page: Int, size: Int)
    case detail(id: Int)
    case create(title: String, body: String)
    case update(id: Int, title: String)
    case delete(id: Int)

    var path: String {
        switch self {
        case .list:              return "/posts"
        case .detail(let id):    return "/posts/\(id)"
        case .create:            return "/posts"
        case .update(let id, _): return "/posts/\(id)"
        case .delete(let id):    return "/posts/\(id)"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .list, .detail: return .get
        case .create:        return .post
        case .update:        return .put
        case .delete:        return .delete
        }
    }

    var parameters: Parameters? {
        switch self {
        case .list(let page, let size):
            return ["skip": page, "limit": size]
        case .create(let title, let body):
            return ["title": title, "body": body]
        case .update(_, let title):
            return ["title": title]
        default:
            return nil
        }
    }
}


enum AuthEndpoint: Endpoint {
    
    case login(username: String, password: String)
    
    var path: String {
        switch self {
        case .login: return "/auth/login"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .login: return .post
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .login(let username, let password):
            return ["username": username, "password": password]
        }
    }
}

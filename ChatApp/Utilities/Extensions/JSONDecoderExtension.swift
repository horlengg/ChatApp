//
//  JSONDecoderExtension.swift
//  SwiftUIApp
//
//  Created by Houleng Ly on 21/2/26.
//

import SwiftUI

extension JSONDecoder {
    static var `default`: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}

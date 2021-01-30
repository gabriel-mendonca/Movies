//
//  ErrorHandler.swift
//  Movies
//
//  Created by Gabriel Mendonça Sousa Gonçalves  on 29/01/21.
//  Copyright © 2021 Gabriel Mendonça. All rights reserved.
//

import Foundation

struct ErrorHandler: Codable {
    enum Error: Int, Codable {
        //-- balances

        case withoutInternet = -1009
        case unknown         = -1
        
    }
    
    struct ErrorResponse: Codable {
        var errors: [ErrorMessage]
    }

    /// Error Message
    struct ErrorMessage: Codable {
        var errorType: Error? {
            guard let code = Int(self.code) else {
                return  Error.unknown
            }

            if let selectedError = Error(rawValue: code) {
                return selectedError

            }
            return Error.unknown
        }

        var code: String
        var message: String
    }
}

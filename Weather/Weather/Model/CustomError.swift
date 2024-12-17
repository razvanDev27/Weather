//
//  CustomError.swift
//  Weather
//
//  Created by Razvan Copaciu on 17.12.2024.
//

import Foundation
import Alamofire

class CustomError: Swift.Error, LocalizedError {
    var afError: AFError? = nil
    var statusCode: Int? = nil

    init(_ error: Swift.Error, statusCode: Int? = nil) {
        self.afError = error.asAFError
        self.statusCode = statusCode
    }

    var errorDescription: String? {
        afError?.errorDescription ?? "Something went wrong"
    }
}

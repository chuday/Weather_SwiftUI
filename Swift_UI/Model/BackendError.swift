//
//  BackendError.swift
//  Swift_UI
//
//  Created by Mikhail Chudaev on 12.12.2021.
//

import Foundation

enum BackendError: Error {
    case cityNotFound(message: String)
}

extension BackendError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case let .cityNotFound(message):
            return NSLocalizedString(message, comment: "")
        }
    }
}

enum ApplicationError: Error {
    case loginInputIncorrect(message: String)
}

extension ApplicationError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case let .loginInputIncorrect(message):
            return NSLocalizedString(message, comment: "")
        }
    }
}

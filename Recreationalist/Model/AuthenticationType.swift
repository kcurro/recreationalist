//
//  AuthenticationType.swift
//  Recreationalist
//
//  Created by Kimberly Govea on 4/21/21.
//

import Foundation

enum AuthenticationType: String {
    case signin
    case signup

    var text: String {
        rawValue.capitalized
    }

    var assetBackgroundName: String {
        self == .signin ? "Sign In" : "Sign Up"
    }

    var footerText: String {
        switch self {
            case .signin:
                return "Not a Member? Sign Up"

            case .signup:
                return "Already a Member? Sign In"
        }
    }
}

extension NSError: Identifiable {
    public var id: Int { code }
}

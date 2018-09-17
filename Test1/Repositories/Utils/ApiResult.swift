//
//  ApiResult.swift
//  Test1
//
//  Created by Georgi Stanev on 17.09.18.
//  Copyright © 2018 Georgi Stanev. All rights reserved.
//

import Foundation

enum ApiResult<Data> {
    //Represents a Loading state of the request
    case loading

    //Represents a success from the request
    case success(withData: Data)

    //Represents an Error
    case error(withData: ApiError)

    public var isLoading: Bool {
        guard case .loading = self else { return false }
        return true
    }

    public var isSuccess: Bool {
        guard case .success(_) = self else { return false }
        return true
    }

    public var isError: Bool {
        guard case .error(_) = self else { return false }
        return true
    }

    public func getSuccess() -> Data? {
        guard case let .success(data) = self else { return nil }
        return data
    }

    public func getError() -> ApiError? {
        guard case let .error(data) = self else { return nil }
        return data
    }
}

public struct ApiError {
    let detail: String
    let status: HTTPStatusCodes
    let title: String
    let type: String
    let validationMessages: [String: [String: String]]
}

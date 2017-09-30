//
//  RequestProvider.swift
//  Pods
//
//  Created by Artem Kalmykov on 8/16/17.
//
//

import Foundation
import Alamofire

public enum NetworkingResponseType
{
    case json
    case data
}

public enum NetworkingParametersEncoding
{
    case url
    case json
    
    internal var alamofireEncoding: ParameterEncoding
    {
        switch self
        {
        case .json:
            return JSONEncoding.default
        case .url:
            return URLEncoding.default
        }
    }
}

public protocol RequestProvider
{
    var relativeURL: String { get }
    var usesBaseURL: Bool { get }
    var httpMethod: HTTPMethod { get }
    var parameters: Any? { get }
    var parameterEncoding: NetworkingParametersEncoding { get }
    var automaticallyStartRequest: Bool { get }
    var responseType: NetworkingResponseType { get }
    var timeout: Double { get }
}

public extension RequestProvider
{
    var httpMethod: HTTPMethod
    {
        return .get
    }
    
    var automaticallyStartRequest: Bool
    {
        return true
    }
    
    var responseType: NetworkingResponseType
    {
        return .json
    }
    
    var parameters: Any?
    {
        return nil
    }
    
    var parameterEncoding: NetworkingParametersEncoding
    {
        return .url
    }
    
    var usesBaseURL: Bool
    {
        return true
    }
    
    var timeout: Double
    {
        return Networking.requestTimeout
    }
}

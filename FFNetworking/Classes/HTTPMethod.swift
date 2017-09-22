//
//  HTTPMethod.swift
//  Pods
//
//  Created by Artem Kalmykov on 8/16/17.
//
//

import Foundation
import Alamofire

public enum HTTPMethod
{
    case get
    case post
    case put
    case delete
    case head
    case options
    case connect
    
    public var string: String
    {
        switch self
        {
        case .get:
            return "GET"
        case .post:
            return "POST"
        case .put:
            return "PUT"
        case .delete:
            return "DELETE"
        case .head:
            return "HEAD"
        case .options:
            return "OPTIONS"
        case .connect:
            return "CONNECT"
        }
    }
    
    internal var alamofireMethod: Alamofire.HTTPMethod
    {
        switch self
        {
        case .get:
            return .get
        case .post:
            return .post
        case .put:
            return .put
        case .delete:
            return .delete
        case .head:
            return .head
        case .options:
            return .options
        case .connect:
            return .connect
        }
    }
}

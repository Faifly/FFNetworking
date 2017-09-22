//
//  NetworkingError.swift
//  Pods
//
//  Created by Artem Kalmykov on 8/17/17.
//
//

import Foundation
import Alamofire

open class NetworkingError
{
    public enum Kind
    {
        case connection(reason: String)
        case server(code: StatusCode)
        case serialization
    }
    
    public let kind: Kind
    
    public required init(kind: Kind)
    {
        self.kind = kind
    }
    
    internal static func processError(fromResponse response: DataResponse<Data>) -> NetworkingError?
    {
        guard let afError = response.error else
        {
            return nil
        }
        
        if let code = response.response?.statusCode, let statusCode = StatusCode(rawValue: code)
        {
            return NetworkingError(kind: .server(code: statusCode))
        }
        else
        {
            return NetworkingError(kind: .connection(reason: afError.localizedDescription))
        }
    }
}

//
//  Networking.swift
//  Pods
//
//  Created by Artem Kalmykov on 8/16/17.
//
//

import Foundation

public typealias NetworkingCompletionHandler = (_ success: Bool, _ responseObject: AnyObject?, _ error: NetworkingError?) -> Void

public class Networking
{
    public static var baseURL: String?
    public static var requestTimeout: Double = 10.0
    
    @discardableResult public static func sendRequest(_ provider: RequestProvider, completionHandler: NetworkingCompletionHandler? = nil) -> NetworkingRequest
    {
        let request = NetworkingRequest(provider: provider, completionHandler: completionHandler)
        if provider.automaticallyStartRequest
        {
            request.start()
        }
        return request
    }
    
// MARK: Default headers
    
    public private(set) static var defaultHeaders: [String : String] = [:]
    
    public static func addDefaultHeader(forKey key: String, value: String)
    {
        self.defaultHeaders[key] = value
    }
    
    @discardableResult public static func removeDefaultHeader(withKey key: String) -> String?
    {
        return self.defaultHeaders.removeValue(forKey: key)
    }
}

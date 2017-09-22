//
//  NetworkingRequest.swift
//  Pods
//
//  Created by Artem Kalmykov on 8/16/17.
//
//

import Foundation
import Alamofire

public class NetworkingRequest
{
    private var completionHandler: NetworkingCompletionHandler?
    private var provider: RequestProvider
    private var alamofireRequest: DataRequest!
    
    public required init(provider: RequestProvider, completionHandler: NetworkingCompletionHandler?)
    {
        self.provider = provider
        self.completionHandler = completionHandler
    }
    
    public func start()
    {
        let url = self.composeURL(fromRelativeURL: self.provider.relativeURL, usesBaseURL: self.provider.usesBaseURL)
        let method = self.provider.httpMethod.alamofireMethod
        let parameters = self.provider.parameters as? Parameters ?? nil
        let encoding = self.provider.parameterEncoding.alamofireEncoding
        let headers = Networking.defaultHeaders
        
        self.alamofireRequest = Alamofire.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers)
        self.alamofireRequest.responseData { (response) in
            self.handleResponse(response)
        }
    }
    
    public func cancel()
    {
        self.alamofireRequest.cancel()
    }
    
    private func composeURL(fromRelativeURL relativeURL: String, usesBaseURL: Bool) -> URLConvertible
    {
        if let base = Networking.baseURL, base != "", usesBaseURL
        {
            return base + relativeURL
        }
        else
        {
            return relativeURL
        }
    }
    
    private func handleResponse(_ response: DataResponse<Data>)
    {
        guard let completionHandler = self.completionHandler else
        {
            return
        }
        
        let serializationResult = self.serializeResponse(response)
        
        if let error = NetworkingError.processError(fromResponse: response)
        {
            completionHandler(false, serializationResult.0, error)
        }
        else if let serializationError = serializationResult.1
        {
            completionHandler(false, serializationResult.0, serializationError)
        }
        else
        {
            completionHandler(true, serializationResult.0, nil)
        }
    }
    
    private func serializeResponse(_ response: DataResponse<Data>) -> (AnyObject?, NetworkingError?)
    {
        guard let data = response.result.value else
        {
            return (nil, nil)
        }
        
        switch self.provider.responseType
        {
        case .data:
            return (data as AnyObject?, nil)
        case .rawJson:
            do
            {
                let result = try JSONSerialization.jsonObject(with: data, options: [])
                return (result as AnyObject?, nil)
            }
            catch
            {
                return (nil, NetworkingError(kind: .serialization))
            }
        }
    }
}

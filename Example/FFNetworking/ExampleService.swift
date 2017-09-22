//
//  ExampleService.swift
//  FFNetworking
//
//  Created by Artem Kalmykov on 8/17/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import FFNetworking

enum ExampleRequest
{
    case simpleGET
    case getWithArguments(arg1: String, arg2: Int)
    case postRequest(data: String)
}

extension ExampleRequest: RequestProvider
{
    var relativeURL: String
    {
        switch self
        {
        case .simpleGET:
            return "ip"
        case .getWithArguments(_, _):
            return "get"
        case .postRequest(_):
            return "post"
        }
    }
    
    var httpMethod: HTTPMethod
    {
        switch self
        {
        case .simpleGET, .getWithArguments(_, _):
            return .get
        case .postRequest(_):
            return .post
        }
    }
    
    var parameters: Any?
    {
        switch self
        {
        case .simpleGET:
            return nil
        case .getWithArguments(let arg1, let arg2):
            return [
                "arg1": arg1,
                "arg2": arg2
            ]
        case .postRequest(let data):
            return [
                "data": data
            ]
        }
    }
}

class ExampleService
{
    static func sendSimpleGet()
    {
        Networking.sendRequest(ExampleRequest.simpleGET) { (success, responseObject, error) in
            print("Success: \(success)")
            print("Response object: \(String(describing: responseObject))")
            print("Error: \(String(describing: error))")
        }
    }
    
    static func sendGetWithParameters()
    {
        Networking.sendRequest(ExampleRequest.getWithArguments(arg1: "test1", arg2: 12)) { (success, responseObject, error) in
            print("Success: \(success)")
            print("Response object: \(String(describing: responseObject))")
            print("Error: \(String(describing: error))")
        }
    }
    
    static func sendPostRequest()
    {
        Networking.sendRequest(ExampleRequest.postRequest(data: "123")) { (success, responseObject, error) in
            print("Success: \(success)")
            print("Response object: \(String(describing: responseObject))")
            print("Error: \(String(describing: error))")
        }
    }
}

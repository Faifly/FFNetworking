//
//  ViewController.swift
//  FFNetworking
//
//  Created by ArKalmykov on 08/16/2017.
//  Copyright (c) 2017 ArKalmykov. All rights reserved.
//

import UIKit
import FFNetworking

class ViewController: UIViewController
{
    // MARK: View controller
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.setupNetworking()
    }
    
    // MARK: Setup
    
    private func setupNetworking()
    {
        Networking.baseURL = "https://httpbin.org/"
        Networking.addDefaultHeader(forKey: "Authorization", value: "auth-h")
    }
    
    // MARK: Event handlers
    
    @IBAction func onSimpleGetRequest()
    {
        ExampleService.sendSimpleGet()
    }
    
    @IBAction func onGetWithArguments()
    {
        ExampleService.sendGetWithParameters()
    }
    
    @IBAction func onPostRequest()
    {
        ExampleService.sendPostRequest()
    }
}


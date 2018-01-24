//
//  AuthService.swift
//  Foodtruck Finder
//
//  Created by Mayara Felix on 2018-01-23.
//  Copyright © 2018 Mayara Felix. All rights reserved.
//

import Foundation

class AuthService
{
    static let instance = AuthService()
    
    let defaults = UserDefaults.standard
    
    var isRegistered: Bool? {
        get {
            return defaults.bool(forKey: DEFAULTS_REGISTERED) == true
        }
        set {
            defaults.set(newValue, forKey: DEFAULTS_REGISTERED)
        }
    }
    
    var isAuthenticated: Bool? {
        get {
            return defaults.bool(forKey: DEFAULTS_AUTHENTICATED) == true
        }
        set {
            defaults.set(newValue, forKey: DEFAULTS_AUTHENTICATED)
        }
    }
    
    var email: String? {
        get {
            return defaults.value(forKey: DEFAULTS_EMAIL) as? String
        }
        set {
            defaults.set(newValue, forKey: DEFAULTS_EMAIL)
        }
    }
    
    var authToken: String? {
        get {
            return defaults.value(forKey: DEFAULTS_TOKEN) as? String
        }
        set {
            defaults.set(newValue, forKey: DEFAULTS_TOKEN)
        }
    }
    
    func registerUser(email username: String, password: String, completion: @escaping callback)
    {
        let json = ["email": username, "password": password]
        
        let sessionConfig = URLSessionConfiguration.default;
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        
        guard let URL = URL(string: POST_REGISTER_ACCT) else {
            isRegistered = false
            completion(false)
            return
        }
        
        var request = URLRequest(url: URL)
        request.httpMethod = "POST"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do
        {
            let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            request.httpBody = jsonData
            
            let task = session.dataTask(with: request, completionHandler:
            { (data: Data?, response: URLResponse?, error: Error?) -> Void in
                if (error == nil)
                {
                    let statusCode = (response as! HTTPURLResponse).statusCode
                    print("URL Sesson Task succeeded: HTPP \(statusCode)")
                    
                    if ( statusCode != 200 && statusCode != 409)
                    {
                        self.isRegistered = false
                        completion(false)
                        return
                    }
                    else
                    {
                        self.isRegistered = true
                        completion(true)
                    }
                }
                else
                {
                    print("URL Session Task Failed: \(error!.localizedDescription)")
                    completion(false)
                }
            })
            
            task.resume()
            session.finishTasksAndInvalidate()
            
        }
        catch let err
        {
            self.isRegistered = false
            completion(false)
            print(err)
        }
    }
    
    func logIn(email username: String, password: String, completion: @escaping callback)
    {
        let json = ["email": username, "password": password]
        
        let sessionConfig = URLSessionConfiguration.default;
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        
        guard let URL = URL(string: POST_LOGIN_ACCT) else {
            isAuthenticated = false
            completion(false)
            return
        }
        
        var request = URLRequest(url: URL)
        request.httpMethod = "POST"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do
        {
            let jsonData = try JSONSerialization.data(withJSONObject: json, options: [])
            request.httpBody = jsonData
            
            let task = session.dataTask(with: request, completionHandler:
            { (data: Data?, response: URLResponse?, error: Error?) -> Void in
                if (error == nil)
                {
                    let statusCode = (response as! HTTPURLResponse).statusCode
                    print("URL Sesson Task succeeded: HTPP \(statusCode)")
                    
                    if ( statusCode != 200)
                    {
                        self.isAuthenticated = false
                        completion(false)
                        return
                    }
                    else
                    {
                        guard let data = data else {
                            self.isAuthenticated = false
                            completion(false)
                            return
                        }
                        
                        do
                        {
                            let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Dictionary<String, AnyObject>
                            
                            if result != nil
                            {
                                if let email = result?["user"] as? String
                                {
                                    if let token = result?["token"] as? String
                                    {
                                        self.email = email
                                        self.authToken = token
                                        self.isAuthenticated = true
                                        self.isRegistered = true
                                        completion(true)
                                    }
                                    else
                                    {
                                        completion(false)
                                    }
                                }
                                else
                                {
                                    completion(false)
                                }
                            }
                        }
                        catch let err
                        {
                            completion(false)
                            print(err)
                        }
                    }
                }
                else
                {
                    print("URL Session Task Failed: \(error!.localizedDescription)")
                    completion(false)
                    return
                }
            })
            
            task.resume()
            session.finishTasksAndInvalidate()
            
        }
        catch let err
        {
            completion(false)
            print(err)
        }
    }
}

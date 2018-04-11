//
//  LoginAPI.swift
//  MyAwesomeProjectPackageDescription
//
//  Created by Tyler Wells on 3/22/18.
//

import Foundation
import Alamofire

enum callMethod {
    case get
    case post
    case delete
}

enum APIError: String, Error {
    case urlNil = "invalid url"
    case requestFailed = "request failed"
    case noJSON = "JSON not returned or invalid"
}

class APISession {
    
    public var defaultSession = URLSession(configuration: .default)
    private var dataTask: URLSessionDataTask? = nil
    public var callMethod: callMethod = .get
    public var parameters:[String:String]? = nil
    public var headers:[String:String]? = nil
    private var requestURL: URL? = nil
    
    fileprivate class GenericResponse {
        
        var data: Data? = nil
        var response: URLResponse? = nil
        
        init(data: Data?, response: URLResponse?) {
            self.data = data
            self.response = response
        }
        deinit {
            self.data = nil
            self.response = nil
        }
    }
    
    
    init?(urlString: String, callMethod: callMethod = .get, parameters: [String:String]? = nil, headers: [String:String]? = nil) {
        guard let url = URL(string: urlString) else {
            return nil
        }
        self.requestURL = url
        self.callMethod = callMethod
        self.parameters = parameters
        self.headers = headers
    }
    
    deinit {
        self.dataTask = nil
        self.parameters = nil
        self.headers = nil
        self.requestURL = nil
    }
    
    public func request() {
        
        
    }
    
    
    private func networkRequest(completion: @escaping ()->GenericResponse) {
        dataTask?.cancel()
        guard let url = requestURL else {
             return
        }
        dataTask = defaultSession.dataTask(with: url) { data, response, error in
            defer{ self.dataTask = nil }
            if error != nil {
                print("DataTask error: " + error!.localizedDescription + "\n")
                return
            }
            //completion(return GenericResponse(data: data, response: response))
        }
        dataTask?.resume()
    }
    
    func responseJSON(){
        
        
    }
    
    public class func createUser(){}
    
    public class func check(success: @escaping ()->Void) {
        print("now getting")
        if let url = URL(string: "https://todoapp784512.herokuapp.com/") {
            print("now getting")
            
            // 1
            let defaultSession = URLSession(configuration: .default)
            // 2
            var dataTask: URLSessionDataTask?
            
            // 1
            dataTask?.cancel()
            dataTask = defaultSession.dataTask(with: url) { data, response, error in
            defer { dataTask = nil }
                    // 5
                    if let error = error {
                        print("DataTask error: " + error.localizedDescription + "\n")
                    } else if let data = data,
                        let response = response as? HTTPURLResponse,
                        response.statusCode == 200 {
                        print(data)
                        
                        // 6
                        DispatchQueue.main.async {
                           // completion(self.tracks, self.errorMessage)
                        }
                    }
                }
                // 7
                dataTask?.resume()
            
//            Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil)
//                .response(completionHandler: {response in print(response)})
//                .responseJSON(completionHandler: {response in
//                    if response.error != nil {
//                        print(response.error)
//                        return
//                    }
//
//                    if let json = response.result.value {
//                        print("JSON: \(json)")
//                        //success()
//                    } else {print("NO JSON")}
//                })
        } else {print("NO URL")}
    }
    
    public class func login(email: String, password: String, success: @escaping () -> Void) {
        if let url = URL(string: "https://todoapp784512.herokuapp.com/login") {
            print("Now Logging in")
            
//            Alamofire.request(URL(string: "https://todoapp784512.herokuapp.com/")!, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseString(completionHandler: {response in print(response)})
//                .responseJSON(completionHandler: {response in
//                    if response.error != nil {
//                        print(response.error)
//                        return
//                    }
//                    print(response)
//                    if let json = response.result.value {
//                        print("JSON: \(json)")
//                    } else {print("NO JSON")}
//                })
            
            let parameters:[String:String] = ["email":email, "password":password]
            
            Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil)
                .responseJSON(completionHandler: {response in
                if response.error != nil {
                    print(response.error)
                    return
                }
                
                if let json = response.result.value {
                    print("JSON: \(json)")
                    //success()
                } else {print("NO JSON")}
            })
        } else {print("NO URL")}
    }
    
    
    
    
}

//
//  ServiceFactory.swift
//  Mansur Media
//
//  Created by Mansur on 30/08/20.
//  Copyright © 2020 MansurBagwan. All rights reserved.
//

import UIKit

class ServiceFactory: NSObject {
    
    typealias CallBackGet = (AnyObject?, Error?, Bool) -> Void
    
    func callGetWithURL(strURL:String?, parameters: [String: Any]?, callBack:@escaping CallBackGet) {
        
        var responceDictinary: AnyObject?
        
        let url = URL(string: strURL ?? "")
        
        var request: URLRequest? = nil
        if let url = url {
            request = URLRequest(url: url)
        }
        
        request?.httpMethod = "GET"
        
        let sessionConfiguration = URLSessionConfiguration.default
        
        sessionConfiguration.timeoutIntervalForRequest = 60
        
        let session = URLSession(configuration: sessionConfiguration, delegate: nil, delegateQueue:OperationQueue.main)
        if let urlRequest = request
        {
            
            let sessionTask = session.dataTask(with: urlRequest) { data, responce, error in
                guard let data = data, let response = responce as? HTTPURLResponse, error == nil else{
                    return
                }
                
                do {
                    let jsonDictinoary = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
                    responceDictinary = jsonDictinoary as AnyObject
                    if (response.statusCode >= 200 && response.statusCode <= 299)
                    {
                        callBack(responceDictinary,nil,true)
                    }
                    else
                    {
                        callBack(responceDictinary,nil,false)
                    }
                } catch {
                    callBack(nil,error,false)
                }
                
            }
            
            sessionTask.resume()
        }
        
    }
    
}

//
//  ApiManager.swift
//  TestTekus
//
//  Created by Oswaldo Garcia on 1/27/17.
//  Copyright © 2017 Oswaldo Garcia. All rights reserved.
//

import Foundation
import Alamofire

class ApiManager{
    
    let baseURL = "http://proyectos.tekus.co/Test/api/notifications/"
    
    let headers : HTTPHeaders = [
        "content-type": "application/json",
        "Authorization": "Basic 19354826"
    ]
    
    
    func request(completionHandler: @escaping (Array<Any>) -> Void) {
        
        Alamofire.request(self.baseURL, method:.get,headers: self.headers)
            .responseJSON { response in

                //print(response)
                
                completionHandler(response.value as! Array)
                
        }
        
    }
    
    func getRequest(id:String) {
        
        let url = self.baseURL + id
        
        Alamofire.request(url, method:.get,headers: self.headers)
            .responseJSON { response in
                
                //print(response)
                
        }
        
    }
    
    
    
    func postRequest(parameters : Parameters,completionHandler: @escaping (Dictionary<String, Any>) -> Void)  {
        
        Alamofire.request(self.baseURL, method:.post, parameters:parameters, encoding: JSONEncoding.default,headers: self.headers)
            .responseJSON { response in
                
               // print(response.value!)
                
                completionHandler(response.value as! Dictionary)


        }
        
    }
    
    func putRequest(parameters : Parameters,id:String) {
        
        let url = self.baseURL + id
        
        Alamofire.request(url, method:.put, parameters:parameters, encoding: JSONEncoding.default,headers: self.headers)
            .responseJSON { response in
                
                //print(response)
                
        }
        
    }
    func deleteRequest(id:String) {
        
        let url = self.baseURL + id
     
        Alamofire.request(url, method:.delete,headers: self.headers)
            .responseJSON { response in
                
                //print(response)
                
        }
        
    }
    
    
}

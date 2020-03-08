//
//  APIService.swift
//  TranslaterProject
//
//  Created by Hayk Qolozyan on 3/7/20.
//  Copyright © 2020 Hayk Qolozyan. All rights reserved.
//



import UIKit
import Alamofire

class APIService {
    
    static func fetchMeanings(with pageNumber: Int, pageSize: Int, translateString: String, completion:@escaping ([ResponseSrtuct]?, Error?)->Void)  {
        
        let dict: Dictionary = ["pageSize": pageSize,
                                "page": pageNumber,
                                "search": translateString] as [String : Any]
        
        let urlString = "https://dictionary.skyeng.ru/api/public/v1/words/search"
        let headers: HTTPHeaders = [HTTPHeader(name: "format", value: "json")]
        
        AF.request(urlString, method: .get, parameters: dict, headers: headers).responseDecodable(of: [ResponseSrtuct].self) { response in
            
            switch response.result {
            case .success(let meanings):
                
                completion(meanings, nil)
                break
                
            case .failure(let error):
                
                completion(nil, error)
                break
            }
        }
    }
}

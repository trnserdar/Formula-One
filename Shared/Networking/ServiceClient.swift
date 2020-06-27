//
//  ServiceClient.swift
//  FormulaOne
//
//  Created by Serdar Turan on 27.06.2020.
//

import Foundation
import Alamofire

class ServiceClient {
    
    static func makeRequest<T: Codable>(route: URLRequestConvertible, decodingType: T.Type, completion: @escaping (_ response: T?, _ error: Error?) -> Void) {
        
        AF.request(route).validate().responseDecodable(of: T.self) { (response) in
            completion(response.value, response.error)
        }
    }
}

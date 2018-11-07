//
//  API.swift
//  MobiTalksTDDiOS
//
//  Created by Victor Magalhaes on future.
//  Copyright © 2018 MobiTalks. All rights reserved.
//

import Foundation

enum HttpMethod: String {
    case post = "POST"
}

enum HttpResponse {
    case success
    case error
}

class API {
    
    func request<T: Decodable>(url: [PathURL], parameters: [String: Any], httpMethod: HttpMethod, completion: @escaping (T?, String?) -> ()) {
        
        guard let request = makeRequest(
            url: url,
            parameters:
            parameters,
            method: httpMethod) else { return }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let response = response as? HTTPURLResponse else {
                completion(nil, "Houve um problema de conexão com nosso serviço, tente novamente dentro de alguns minutos")
                return
            }
            switch response.statusCode {
            case 400..<600:
                completion(nil, "Erro \(response.statusCode) \(error)")
            default:
                guard let `data` = data else { return }
                
                do  {
                    let object = try JSONDecoder().decode(T.self, from: data)
                    completion(object, nil)
                } catch let jsonError {
                    completion(nil, "ERRO JSON \(jsonError.localizedDescription) \(response.statusCode)")
                }
            }
            
            }.resume()
    }
    
    private func makeRequest(url: [PathURL], parameters: [String: Any], method: HttpMethod) -> URLRequest? {
        
        let currentUrl = url.reduce("") { $0 + $1.rawValue }
        print(currentUrl)
        guard let `url` = URL(string: currentUrl) else { return nil}
        
        var request = URLRequest(
            url: url,
            cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
            timeoutInterval: 10
        )
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters    , options: .prettyPrinted)
        } catch {
            print(error.localizedDescription)
        }
        
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpMethod = method.rawValue
        return request
    }
}


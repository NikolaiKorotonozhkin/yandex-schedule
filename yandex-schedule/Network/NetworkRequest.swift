//
//  NetworkRequest.swift
//  yandex-schedule
//
//  Created by Nikolai  on 07.12.2023.
//

import Foundation

class NetworkRequest {
    
    static let shared = NetworkRequest()
    private init() {}
    
    func requestData(urlString: String, completion: @escaping(Result<Data, Error>) -> Void) {
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                print(data)
                completion(.success(data))
            }
        }
        .resume()
    }
}

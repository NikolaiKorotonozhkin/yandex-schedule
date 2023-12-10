//
//  NetworkDataFetch.swift
//  yandex-schedule
//
//  Created by Nikolai  on 07.12.2023.
//

import Foundation

enum NetworkConstants: String {
    case ApiKey = "bca89ae3-7648-4682-a0dd-e8dfc5d8cef8"
}

class NetworkDataFetch {
    
    static let shared = NetworkDataFetch()
    private init() {}
    
    func fetchStations(urlString: String, response: @escaping(Station?, Error?) -> Void) {
        NetworkRequest.shared.requestData(urlString: urlString) { result in
            switch result {
            case .success(let data):
                do {
                    let stations = try JSONDecoder().decode(Station.self, from: data)
                    response(stations, nil)
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                }
            case .failure(let error):
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil, error)
            }
        }
    }
    
    func fetchScheduleBetweenStations(urlString: String, response: @escaping(ScheduleBetweenStations?, Error?) -> Void) {
        NetworkRequest.shared.requestData(urlString: urlString) { result in
            switch result {
            case .success(let data):
                do {
                    let schedule = try JSONDecoder().decode(ScheduleBetweenStations.self, from: data)
                    response(schedule, nil)
                } catch let jsonError {
                    print("Failed to decode JSON Schedule", jsonError)
                }
            case .failure(let error):
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil, error)
            }
        }
    }
    
}

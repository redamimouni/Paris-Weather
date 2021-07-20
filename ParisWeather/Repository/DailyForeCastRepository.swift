//
//  DailyForeCastRepository.swift
//  ParisWeather
//
//  Created by reda.mimouni on 14/07/2021.
//

import Foundation

protocol DailyForeCastRepositoryProtocol {
    func getDailyForeCast(completionHandler: @escaping (Result<DailyForeCastEntity, Error>) -> Void)
}

class DailyForeCastRepositoryImpl: DailyForeCastRepositoryProtocol {
    
    private let service: DailyForeCastServiceProtocol
    
    init(service: DailyForeCastServiceProtocol) {
        self.service = service
    }
    
    func getDailyForeCast(completionHandler: @escaping (Result<DailyForeCastEntity, Error>) -> Void) {
        service.getDailyForeCast { response in
            switch response {
            case .success(let data):
                do {
                    let returnValue = try JSONDecoder().decode(DailyForeCastEntity.self, from: data)
                    completionHandler(.success(returnValue))
                }
                catch {
                    completionHandler(.failure(error))
                    print("Error took place\(error.localizedDescription).")
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
}



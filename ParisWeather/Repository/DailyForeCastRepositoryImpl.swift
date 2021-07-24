//
//  DailyForeCastRepository.swift
//  ParisWeather
//
//  Created by reda.mimouni on 14/07/2021.
//

import Foundation

protocol DailyForeCastRepositoryProtocol {
    var entity: DailyForeCastEntity? { get }

    func getDailyForeCast(completionHandler: @escaping (Result<DailyForeCastEntity, CustomError>) -> Void)
    func getForecastFor(day timeStamp: Int, completionHandler: @escaping (Result<List, CustomError>) -> Void)
}

class DailyForeCastRepositoryImpl: DailyForeCastRepositoryProtocol {
    var entity: DailyForeCastEntity?
    
    private let service: DailyForeCastServiceProtocol
    
    init(service: DailyForeCastServiceProtocol) {
        self.service = service
    }
    
    func getDailyForeCast(completionHandler: @escaping (Result<DailyForeCastEntity, CustomError>) -> Void) {
        service.getDailyForeCast { [weak self] response in
            switch response {
            case .success(let data):
                do {
                    let jsonFromData = try JSONDecoder().decode(DailyForeCastEntity.self, from: data)
                    self?.entity = jsonFromData
                    completionHandler(.success(jsonFromData))
                }
                catch {
                    completionHandler(.failure(.parsingError))
                    print("Error took place\(error.localizedDescription).")
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func getForecastFor(day timeStamp: Int, completionHandler: @escaping (Result<List, CustomError>) -> Void) {
        guard let entity = self.entity?.list.first(where: {
            $0.dt == timeStamp
        }) else {
            completionHandler(.failure(CustomError.dayNotFound))
            return
        }
        completionHandler(.success(entity))
    }
}

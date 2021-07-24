//
//  DailyForecastRepositoryMock.swift
//  ParisWeatherTests
//
//  Created by reda.mimouni on 21/07/2021.
//

import Foundation
@testable import ParisWeather

class DailyForecastRepositoryMock: DailyForeCastRepositoryProtocol {
    var entity: DailyForeCastEntity?
    
    private let isSuccess: Bool
    init(isSucess: Bool) {
        isSuccess = isSucess
    }
    
    func getDailyForeCast(completionHandler: @escaping (Result<DailyForeCastEntity, CustomError>) -> Void) {
        isSuccess ? completionHandler(.success(DailyForeCastEntity.mock)) : completionHandler(.failure(.parsingError))
    }
    
    func getForecastFor(day timeStamp: Int, completionHandler: @escaping (Result<List, CustomError>) -> Void) {
        isSuccess ? completionHandler(.success(List.mock)) : completionHandler(.failure(.parsingError))
    }
}

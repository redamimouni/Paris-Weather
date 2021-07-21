//
//  DailyForecastRepositoryMock.swift
//  ParisWeatherTests
//
//  Created by reda.mimouni on 21/07/2021.
//

import Foundation
@testable import ParisWeather

class DailyForecastRepositoryMock: DailyForeCastRepositoryProtocol {
    private let isSuccess: Bool
    init(isSucess: Bool) {
        isSuccess = isSucess
    }
    
    func getDailyForeCast(completionHandler: @escaping (Result<DailyForeCastEntity, CustomError>) -> Void) {
        isSuccess ? completionHandler(.success(DailyForeCastEntity.mock)) : completionHandler(.failure(.parsingError))
    }
}

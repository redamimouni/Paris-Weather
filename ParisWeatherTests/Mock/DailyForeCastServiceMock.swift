//
//  DailyForeCastRepositoryMock.swift
//  ParisWeatherTests
//
//  Created by reda.mimouni on 14/07/2021.
//

import Foundation
@testable import ParisWeather

class DailyForeCastServiceMock: DailyForeCastServiceProtocol {
    lazy var fileName: String = {
        return success ? "dailyForeCastResponseSuccess" : "dailyForeCastResponseContractError"
    }()
    private let success: Bool
    
    init(isSuccess: Bool) {
        success = isSuccess
    }
    
    func getDailyForeCast(completionHandler: @escaping (Result<Data, CustomError>) -> Void) {
        guard let data = TestUtils.readLocalFile(forName: fileName)
        else {
            completionHandler(.failure(.unknownError))
            return
        }
        completionHandler(.success(data))
    }
}

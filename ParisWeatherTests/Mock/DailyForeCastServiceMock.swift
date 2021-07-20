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
        return success ? "dailyForeCastResponseSuccess" : "dailyForeCastResponseFailure"
    }()
    let success: Bool
    
    init(isSuccess: Bool) {
        success = isSuccess
    }
    
    func getDailyForeCast(completionHandler: @escaping (Result<Data, Error>) -> Void) {
        guard let data = TestUtils.readLocalFile(forName: fileName)
        else {
            completionHandler(.failure(TestUtilsException.cantReadFileError))
            return
        }
        completionHandler(.success(data))
    }
}

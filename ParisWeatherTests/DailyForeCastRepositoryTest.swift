//
//  DailyForeCastRepositoryTest.swift
//  ParisWeatherTests
//
//  Created by reda.mimouni on 14/07/2021.
//

import XCTest
@testable import ParisWeather

class DailyForeCastRepositoryTest: XCTestCase {
    private let expectedSuccessDailyForeCast = DailyForeCastEntity.mock

    func testCallGetDailyForeCastShouldReturnSuccessEntity() {
        // Given
        let service = DailyForeCastServiceMock(isSuccess: true)
        let repository = DailyForeCastRepositoryImpl(service: service)
        
        // When
        repository.getDailyForeCast { result in
            // Then
            switch result {
            case .success(let entity):
                XCTAssertEqual(entity, self.expectedSuccessDailyForeCast)
            case .failure(_):
                XCTFail()
            }
        }
    }
    
    func testCallGetDailyForeCastShouldReturnFailureEntity() {
        // Given
        let service = DailyForeCastServiceMock(isSuccess: false)
        let repository = DailyForeCastRepositoryImpl(service: service)
        
        // When
        repository.getDailyForeCast { result in
            // Then
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error, .parsingError)
            }
        }
    }

}


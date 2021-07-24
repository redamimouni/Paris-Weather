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
    private let expectedSuccessForeCastForDay = List.mock
    private let service = DailyForeCastServiceMock(isSuccess: true)

    
    func testCallGetDailyForeCastShouldReturnSuccessEntity() {
        // Given
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

    func testCallGetForecastForDayShouldReturnSuccessEntity() {
        // Given
        let repository = DailyForeCastRepositoryImpl(service: service)
        repository.entity = DailyForeCastEntity.mock
        
        // When
        repository.getForecastFor(day: 1626260400) { result in
            // Then
            switch result {
            case .success(let entity):
                XCTAssertEqual(entity, self.expectedSuccessForeCastForDay)
            case .failure(_):
                XCTFail()
            }
        }
    }
    
    func testCallGetForecastForDayShouldReturnDayNotFountError() {
        // Given
        let repository = DailyForeCastRepositoryImpl(service: service)
        repository.entity = DailyForeCastEntity.mock

        // When
        repository.getForecastFor(day: 1626260401) { result in
            // Then
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error, .dayNotFound)
            }
        }
    }
}


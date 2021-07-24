//
//  ForecastDetailViewModelTest.swift
//  ParisWeatherTests
//
//  Created by reda.mimouni on 24/07/2021.
//

import XCTest
@testable import ParisWeather

class ForecastDetailViewModelTest: XCTestCase {
    
    func testgetForecastDetailShouldReturnSuccessModel() {
        // Given
        let repository = DailyForecastRepositoryMock(isSucess: true)
        let viewModel = ForecastDetailViewModel(repository: repository)
        
        // When
        viewModel.getForecastDetail(day: 1626260400)
        
        // Then
        XCTAssertEqual(viewModel.forecastDetailData, .success(ForecastDetailModel.mock))
    }
    
    func testgetForecastDetailShouldReturnErrorModel() {
        // Given
        let repository = DailyForecastRepositoryMock(isSucess: false)
        let viewModel = ForecastDetailViewModel(repository: repository)
        
        // When
        viewModel.getForecastDetail(day: 1626260400)
        
        // Then
        XCTAssertEqual(viewModel.forecastDetailData, .failure(.parsingError))
    }
}

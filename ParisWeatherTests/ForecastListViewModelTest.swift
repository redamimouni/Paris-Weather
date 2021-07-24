//
//  ForecastListViewModel.swift
//  ParisWeatherTests
//
//  Created by reda.mimouni on 21/07/2021.
//

import XCTest
@testable import ParisWeather

class ForecastListViewModelTest: XCTestCase {
    
    func testgetForecastListShouldReturnSuccessModel() {
        // Given
        let repository = DailyForecastRepositoryMock(isSucess: true)
        let viewModel = ForecastListViewModel(repository: repository)
        
        // When
        viewModel.getForecastList()
        
        // Then
        XCTAssertEqual(viewModel.forecastData, .success([ForecastListModel.mock]))
    }
    
    func testgetForecastListShouldReturnFailure() {
        // Given
        let repository = DailyForecastRepositoryMock(isSucess: false)
        let viewModel = ForecastListViewModel(repository: repository)
        
        // When
        viewModel.getForecastList()
        
        // Then
        XCTAssertEqual(viewModel.forecastData, .failure(.parsingError))
    }
}

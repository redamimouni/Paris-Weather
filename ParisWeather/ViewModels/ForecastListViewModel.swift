//
//  ForecastListViewModel.swift
//  ParisWeather
//
//  Created by reda.mimouni on 20/07/2021.
//

import Foundation

class ForecastListViewModel: NSObject {
    
    private var repository: DailyForeCastRepositoryProtocol
    
    private(set) var forecastData: Result<[ForecastListModel], CustomError>? {
        didSet {
            self.bindForecastListViewModelToController()
        }
    }
    
    var bindForecastListViewModelToController : (() -> ()) = {}
    
    init(repository: DailyForeCastRepositoryProtocol) {
        self.repository = repository
    }
    
    func getForecastData() {
        repository.getDailyForeCast { [weak self] result in
            switch result {
            case .success(let entity):
                self?.forecastData = .success(entity.list.map({ it in
                    it.toForecastListModel()
                }))
            case .failure(let error):
                self?.forecastData = .failure(error)
            }
        }
    }
}

struct ForecastListModel: Equatable {
    let temperature: String
    let day: String
}

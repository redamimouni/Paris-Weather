//
//  ForecastListViewModel.swift
//  ParisWeather
//
//  Created by reda.mimouni on 20/07/2021.
//

import Foundation

class ForecastListViewModel: NSObject {
    
    private var repository: DailyForeCastRepositoryProtocol
    
    private(set) var forecastData: [ForecastListModel]! {
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
                self?.forecastData = entity.list.map({ it in
                    it.toForecastListModel()
                })
            case .failure(_): break
                
            }
        }
    }
}

struct ForecastListModel {
    let temperature: String
    let day: String
}

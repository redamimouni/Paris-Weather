//
//  ForecastDetailViewModel.swift
//  ParisWeather
//
//  Created by reda.mimouni on 22/07/2021.
//

import Foundation

class ForecastDetailViewModel: NSObject {
    
    private let repository: DailyForeCastRepositoryProtocol
    
    private(set) var forecastDetailData: Result<ForecastDetailModel, CustomError>? {
        didSet {
            self.bindForecastDetailViewModelToController()
        }
    }
    
    init(repository: DailyForeCastRepositoryProtocol) {
        self.repository = repository
    }
    
    var bindForecastDetailViewModelToController : (() -> ()) = {}
    
    func getForecastDetail(day timeStamp: Int) {
        repository.getForecastFor(day: timeStamp) { [weak self] result in
            switch result {
            case .success(let entity):
                self?.forecastDetailData = .success(entity.toForeCastDetailModel())
            case .failure(let error):
                self?.forecastDetailData = .failure(error)
            }
            
        }
    }
}

struct ForecastDetailModel: Equatable {
    let headerMessage: String
}

extension List {    
    func toForeCastDetailModel() -> ForecastDetailModel {
        return ForecastDetailModel(headerMessage: "\(dt.timeIntervalToDayOfWeek()) will be a \(temp.day > 25 ? "Hot day 🔥" : "Cold day ❄️") dont forget to \(temp.day > 25 ? "drink water 🍺" : "eat your soup 🍵")")
    }
}

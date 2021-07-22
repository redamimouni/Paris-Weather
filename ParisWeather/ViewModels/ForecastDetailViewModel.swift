//
//  ForecastDetailViewModel.swift
//  ParisWeather
//
//  Created by reda.mimouni on 22/07/2021.
//

import Foundation

class ForecastDetailViewModel: NSObject {
    
    private let repository: ForecastDetailRepositoryProtocol
    
    private(set) var forecastDetailData: Result<ForecastDetailModel, CustomError>? {
        didSet {
            self.bindForecastDetailViewModelToController()
        }
    }
    
    init(repository: ForecastDetailRepositoryProtocol) {
        self.repository = repository
    }
    
    var bindForecastDetailViewModelToController : (() -> ()) = {}
    
    func getForecastDetail(day timeStamp: Int) {
        repository.getForecastFor(day: timeStamp) { [weak self] result in
            switch result {
            case .success(let entity):
                guard let model = entity.list.first(where: {
                    $0.dt == timeStamp
                })?.toForeCastDetailModel() else {
                    self?.forecastDetailData = .failure(CustomError.dayNotFound)
                    return
                }
                self?.forecastDetailData = .success(model)
            case .failure(let error):
                self?.forecastDetailData = .failure(error)
            }
            
        }
    }
}

struct ForecastDetailModel {
    let headerMessage: String
}

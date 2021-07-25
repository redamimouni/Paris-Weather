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
    static func == (lhs: ForecastDetailModel, rhs: ForecastDetailModel) -> Bool {
        return lhs.sunriseSunset == rhs.sunriseSunset
            && lhs.temperature == rhs.temperature
            && lhs.pressureHumidity == rhs.pressureHumidity
            && lhs.weather == rhs.weather
    }
    
    let headerMessage: String
    let sunriseSunset: (sunrise: String, sunset: String)
    let temperature: (day: String, min: String, max: String)
    let pressureHumidity: (pressure: String, humidity: String)
    let weather: (main: String, icon: String)
}

extension List {
    func toForeCastDetailModel() -> ForecastDetailModel {
        return ForecastDetailModel(headerMessage: "\(dt.timeIntervalToDateFormat(dateFormat: "EEEE")) will be a \(temp.day > 25 ? "Hot day 🔥" : "Cold day ❄️") dont forget to \(temp.day > 25 ? "drink water 🍺" : "eat your soup 🍵")",
                                   sunriseSunset: (sunrise: sunrise.timeIntervalToDateFormat(dateFormat: "h:mm a"),
                                                   sunset: sunset.timeIntervalToDateFormat(dateFormat: "h:mm a")),
                                   temperature: (day: "\(Int(temp.day)) C°",
                                                 min: "\(Int(temp.min)) C°",
                                                 max: "\(Int(temp.max)) C°"),
                                   pressureHumidity: (pressure: "\(pressure) hPa",
                                                      humidity: "\(humidity) %"),
                                   weather: (main: weather.first?.main.rawValue ?? "Unknown",
                                             icon: weather.first?.icon ?? "")
        )
    }
}

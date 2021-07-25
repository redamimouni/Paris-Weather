//
//  ForecastDetailViewController.swift
//  ParisWeather
//
//  Created by reda.mimouni on 22/07/2021.
//

import UIKit

class ForecastDetailViewController: UIViewController {
    
    @IBOutlet var headerMessageLabel: UILabel?
    @IBOutlet var stackView: UIStackView?
    
    var dayTimeStamp: Int!
    var repository: DailyForeCastRepositoryProtocol!
    lazy var forecastDetailViewModel = ForecastDetailViewModel(repository: repository)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerViewModel()
    }
    
    func registerViewModel() {
        forecastDetailViewModel.bindForecastDetailViewModelToController = {
            self.updateUi()
        }
        forecastDetailViewModel.getForecastDetail(day: dayTimeStamp)
    }
    
    private func updateUi() {
        switch forecastDetailViewModel.forecastDetailData {
        case .success(let model):
            headerMessageLabel?.text = model.headerMessage
            let views = buildViewsFromModel(model: model)
            views.forEach { view in
                stackView?.addArrangedSubview(view)
            }
        case .failure(let error):
            displayAlert(with: "Unavailable detail", message: error.localizedDescription)
        case .none:
            displayAlert(with: "Unknow error", message: "Data may be nil")
        }
    }
    
    @IBAction func closeViewController() {
        dismiss(animated: true, completion: nil)
    }
    
    private func buildViewsFromModel(model: ForecastDetailModel) -> [UIView] {
        let sunriseSunsetView = SunriseSunsetView(frame: .zero, model: model.sunriseSunset)
        let temperatureView = TemperatureView(frame: .zero, model: model.temperature)
        let pressureHumidityView = PressureHumidityView(frame: .zero, model: model.pressureHumidity)
        let weatherView = WeatherView(frame: .zero, model: model.weather)
        return [weatherView, sunriseSunsetView, temperatureView, pressureHumidityView]
    }
    
    private func displayAlert(with title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        // Using root viewcontroller because we can't present on presented view controller
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
}

//
//  ViewController.swift
//  ParisWeather
//
//  Created by reda.mimouni on 14/07/2021.
//

import UIKit

class ViewController: UITableViewController {

    private let repository = DailyForeCastRepositoryImpl(service: DailyForeCastServiceImpl(
                                                            apiKey: "648a3aac37935e5b45e09727df728ac2",
                                                            cityName: "Paris",
                                                            count: 16)
    )
    private var forecastListViewModel: ForecastListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callToViewModelForUIUpdate()
    }

    private func callToViewModelForUIUpdate(){
        forecastListViewModel =  ForecastListViewModel(repository: repository)
        forecastListViewModel.bindForecastListViewModelToController = {
                self.updateDataSource()
        }
        forecastListViewModel.getForecastData()
    }
    
    private func updateDataSource() {
        
    }
}


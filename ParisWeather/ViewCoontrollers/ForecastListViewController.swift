//
//  ViewController.swift
//  ParisWeather
//
//  Created by reda.mimouni on 14/07/2021.
//

import UIKit

class ForecastListViewController: UITableViewController {

    private let repository = DailyForeCastRepositoryImpl(service: DailyForeCastServiceImpl(
                                                            apiKey: "648a3aac37935e5b45e09727df728ac2",
                                                            cityName: "Paris",
                                                            count: 16)
    )
    private let dispatcher = DefaultDispatcher()
    private var dataSource : ForecastTableViewDataSource<ForecastTableViewCell, ForecastListModel>!
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
        self.dataSource = ForecastTableViewDataSource(cellIdentifier: "ForecastTableViewCell", items: self.forecastListViewModel.forecastData, configureCell: { (cell, forecastModel) in
            cell.dayLabel.text = forecastModel.day
            cell.temperatureLabel.text = forecastModel.temperature
        })
        
        dispatcher.main {
            self.tableView.dataSource = self.dataSource
            self.tableView.reloadData()
        }
    }
}


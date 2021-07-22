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
    lazy var forecastListViewModel = ForecastListViewModel(repository: repository)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerViewModel()
    }

    private func registerViewModel(){
        forecastListViewModel.bindForecastListViewModelToController = {
                self.updateDataSource()
        }
        forecastListViewModel.getForecastData()
    }
    
    private func updateDataSource() {
        switch forecastListViewModel.forecastData {
        case .success(let data):
            self.dataSource = ForecastTableViewDataSource(cellIdentifier: "ForecastTableViewCell", items: data, configureCell: { (cell, forecastModel) in
                cell.dayLabel.text = forecastModel.day
                cell.temperatureLabel.text = forecastModel.temperature
            })
            
            dispatcher.main {
                self.tableView.dataSource = self.dataSource
                self.tableView.reloadData()
            }
            
        case .failure(let error):
            displayAlert(with: "Fetch error", message: error.localizedDescription)
        case .none:
            displayAlert(with: "Unknow error", message: "Data may be nil")
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        do {
            let selectedForcast = try forecastListViewModel.forecastData?.get()[indexPath.row]
            let detailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ForecastDetail") as! ForecastDetailViewController
            detailViewController.dayTimeStamp = selectedForcast?.timeStamp
            present(detailViewController, animated: true, completion: nil)
        } catch {
            displayAlert(with: "Unavailable detail", message: "Cannot display day forecast")
        }
    }
    
    private func displayAlert(with title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

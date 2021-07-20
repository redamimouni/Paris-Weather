//
//  ForecastTableViewCell.swift
//  ParisWeather
//
//  Created by reda.mimouni on 20/07/2021.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    
    var forecast : ForecastListModel? {
        didSet {
            temperatureLabel.text = forecast?.temperature
            dayLabel.text = forecast?.day
        }
    }
}

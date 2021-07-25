//
//  PressureHumidityView.swift
//  ParisWeather
//
//  Created by reda.mimouni on 25/07/2021.
//

import UIKit

class PressureHumidityView: UIView {
    private var pressureHumidityModel: (pressure: String, humidity: String)!
    
    lazy var pressureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.text = "Pressure: \(pressureHumidityModel.pressure)"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var humidityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.text = "Humidity: \(pressureHumidityModel.humidity)"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(frame: CGRect, model: (String, String)) {
        super.init(frame: frame)
        pressureHumidityModel = model
        setupView()
    }

      
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
    
    private func setupView() {
        addSubview(pressureLabel)
        addSubview(humidityLabel)
        setupLayout()
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate(
            [
                pressureLabel.topAnchor.constraint(equalTo: topAnchor),
                pressureLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
                pressureLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
                humidityLabel.topAnchor.constraint(equalTo: pressureLabel.topAnchor),
                humidityLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
                humidityLabel.leadingAnchor.constraint(equalTo: pressureLabel.leadingAnchor, constant: 10),
                humidityLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
            ]
        )
    }
}

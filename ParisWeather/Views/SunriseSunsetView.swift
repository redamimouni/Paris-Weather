//
//  SunriseSunsetView.swift
//  ParisWeather
//
//  Created by reda.mimouni on 24/07/2021.
//

import UIKit

class SunriseSunsetView: UIView {
    private var sunriseSunsetModel: (sunrise: String, sunset: String)!
    
    lazy var sunriseLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.text = "Sunrise: \(sunriseSunsetModel.sunrise)"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var sunsetLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.text = "Sunset: \(sunriseSunsetModel.sunset)"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(frame: CGRect, model: (String, String)) {
        super.init(frame: frame)
        sunriseSunsetModel = model
        setupView()
    }

      
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
    
    private func setupView() {
        addSubview(sunriseLabel)
        addSubview(sunsetLabel)
        setupLayout()
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate(
            [
                sunriseLabel.topAnchor.constraint(equalTo: topAnchor),
                sunriseLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
                sunriseLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
                sunsetLabel.topAnchor.constraint(equalTo: sunriseLabel.topAnchor),
                sunsetLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
                sunsetLabel.leadingAnchor.constraint(equalTo: sunriseLabel.trailingAnchor, constant: 10),
                sunsetLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
                sunsetLabel.widthAnchor.constraint(equalTo: sunriseLabel.widthAnchor, multiplier: 1.0)
            ]
        )
    }
}

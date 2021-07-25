//
//  WeatherView.swift
//  ParisWeather
//
//  Created by reda.mimouni on 25/07/2021.
//

import UIKit

class WeatherView: UIView {
    var weatherModel: (main: String, icon: String)!
    
    lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.text = "Main waeather: \(weatherModel.main)"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var iconImage: UIImageView = {
        let imageView = UIImageView()
        UIImageView.fetchImage(from: "https://openweathermap.org/img/wn/\(weatherModel.icon).png") { image in
            if let data = image {
                DispatchQueue.main.async {
                    imageView.image = UIImage(data: data)
                }
            } else {
                DispatchQueue.main.async {
                    imageView.image = UIImage(named: "unavailable.png")
                }
            }
        }
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    init(frame: CGRect, model: (String, String)) {
        super.init(frame: frame)
        weatherModel = model
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
    
    private func setupView() {
        addSubview(mainLabel)
        addSubview(iconImage)
        setupLayout()
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate(
            [
                mainLabel.topAnchor.constraint(equalTo: topAnchor),
                mainLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                mainLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
                iconImage.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 20),
                iconImage.centerXAnchor.constraint(equalTo: centerXAnchor),
                iconImage.widthAnchor.constraint(equalToConstant: 80),
                iconImage.heightAnchor.constraint(equalToConstant: 80),
                iconImage.bottomAnchor.constraint(equalTo: bottomAnchor)
            ]
        )
    }
}

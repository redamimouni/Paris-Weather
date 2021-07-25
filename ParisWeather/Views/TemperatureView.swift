//
//  TemperatureView.swift
//  ParisWeather
//
//  Created by reda.mimouni on 25/07/2021.
//

import UIKit

class TemperatureView: UIView {
    private var temparatureModel: (day: String, min: String, max: String)!
    
    lazy var dayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.text = "Day: \(temparatureModel.day)"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var minLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.text = "Minimum: \(temparatureModel.min)"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var maxLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.text = "Maximum: \(temparatureModel.max)"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(frame: CGRect, model: (String, String, String)) {
        super.init(frame: frame)
        temparatureModel = model
        setupView()
    }

      
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
    
    private func setupView() {
        addSubview(dayLabel)
        addSubview(minLabel)
        addSubview(maxLabel)
        setupLayout()
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate(
            [
                dayLabel.topAnchor.constraint(equalTo: topAnchor),
                dayLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
                dayLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
                
                minLabel.topAnchor.constraint(equalTo: dayLabel.topAnchor),
                minLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
                minLabel.leadingAnchor.constraint(equalTo: dayLabel.trailingAnchor),
                minLabel.trailingAnchor.constraint(equalTo: maxLabel.leadingAnchor),
                
                maxLabel.topAnchor.constraint(equalTo: dayLabel.topAnchor),
                maxLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
                maxLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
                
                dayLabel.widthAnchor.constraint(equalTo: minLabel.widthAnchor, multiplier: 1.0),
                maxLabel.widthAnchor.constraint(equalTo: dayLabel.widthAnchor, multiplier: 1.0)
            ]
        )
    }
}

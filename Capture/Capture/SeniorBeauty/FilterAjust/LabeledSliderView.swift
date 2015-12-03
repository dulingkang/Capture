//
//  LabeledSliderView.swift
//  Core Image Explorer
//
//  Created by Warren Moore on 1/10/15.
//  Copyright (c) 2015 objc.io. All rights reserved.
//

import UIKit

class LabeledSliderView: UIView {
    var slider: UISlider!
    var descriptionLabel: UILabel!
    var valueLabel: UILabel!
    var parameter: ScalarFilterParameter!
    var delegate: ParameterAdjustmentDelegate?

    init(frame: CGRect, parameter: ScalarFilterParameter) {
        super.init(frame: frame)

        self.parameter = parameter

        addSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addSubviews() {
        slider = UISlider.init(frame: CGRectMake(0, self.height/2, self.width, self.height/2))
        slider.minimumValue = parameter.minimumValue!
        slider.maximumValue = parameter.maximumValue!
        slider.value = parameter.currentValue
        addSubview(slider)

        slider.addTarget(self, action: "sliderTouchUpInside:", forControlEvents: .TouchUpInside)
        slider.addTarget(self, action: "sliderValueDidChange:", forControlEvents: .ValueChanged)

        descriptionLabel = UILabel.init(frame: CGRectMake(0, 0, self.width, self.height/2))
        descriptionLabel.font = UIFont.boldSystemFontOfSize(14)
        descriptionLabel.textColor = UIColor(white: 0.9, alpha: 1.0)
        descriptionLabel.text = parameter.name
        addSubview(descriptionLabel)

        valueLabel = UILabel.init(frame: CGRectMake(0, 0, self.width, self.height/2))
        valueLabel.font = UIFont.systemFontOfSize(14)
        valueLabel.textColor = UIColor(white: 0.9, alpha: 1.0)
        valueLabel.textAlignment = .Right
        valueLabel.text = slider.value.description
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(valueLabel)
    }

    func sliderValueDidChange(sender: AnyObject?) {
        valueLabel.text = String(format: "%0.2f", slider.value)
    }

    func sliderTouchUpInside(sender: AnyObject?) {
        if delegate != nil {
            delegate!.parameterValueDidChange(ScalarFilterParameter(key: parameter.key, value: slider.value))
        }
    }
}

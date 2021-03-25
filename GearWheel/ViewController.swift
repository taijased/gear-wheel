//
//  ViewController.swift
//  GearWheel
//
//  Created by Максим Спиридонов on 25.03.2021.
//

import UIKit

final class ViewController: UIViewController {
    
    
    
    let gearWheelView: GearWheelView = .init(frame: .zero)
    
    
    fileprivate let errorLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Невозможно построить!"
        view.font = .boldSystemFont(ofSize: 20)
        view.textColor = .systemRed
        view.textAlignment = .center
        view.isHidden = true
        return view
    }()
    
    
    fileprivate let sliderRadiusLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Radius: "
        view.textAlignment = .center
        return view
    }()
    
    
    fileprivate let sliderAngleLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Count: "
        view.textAlignment = .center
        return view
    }()
    
    
    fileprivate let angleHeightLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Height: "
        view.textAlignment = .center
        return view
    }()
    
    fileprivate let sliderAngleHeight: UISlider = {
        let view = UISlider()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(sliderHeightChange), for: .valueChanged)
        view.minimumValue = 1
        view.maximumValue = 50
        return view
    }()
    
    fileprivate let sliderAngle: UISlider = {
        let view = UISlider()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(sliderAngleChange), for: .valueChanged)
        view.minimumValue = 1
        view.maximumValue = 100
        return view
    }()
    
    fileprivate let sliderRadius: UISlider = {
        let view = UISlider()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(sliderRadiusChange), for: .valueChanged)
        view.minimumValue = 20
        view.maximumValue = 150
        return view
    }()
    
    @objc private func sliderRadiusChange(sender: UISlider!) {
        UIView.animate(withDuration: 0.24) {
            self.sliderRadiusLabel.text =  "Radius: \(Int(sender.value))"
        }
        updateGearView()
    }
    
    
    @objc private func sliderAngleChange(sender: UISlider!) {
        UIView.animate(withDuration: 0.24) {
            self.sliderAngleLabel.text =  "Count: \(Int(sender.value))"
        }
        updateGearView()
    }
    
    @objc private func sliderHeightChange(sender: UISlider!) {
        UIView.animate(withDuration: 0.24) {
            self.angleHeightLabel.text =  "Height: \(Int(sender.value))"
        }
        updateGearView()
    }
    
    
    fileprivate func updateGearView() {
        if gearWheelView.canDraw(count: Int(sliderAngle.value), radius: CGFloat(sliderRadius.value)) {
            self.gearWheelView.redraw(count: Int(sliderAngle.value), height: CGFloat(sliderAngleHeight.value), radius: CGFloat(sliderRadius.value))
            UIView.animate(withDuration: 0.24) {
                self.gearWheelView.isHidden = false
                self.errorLabel.isHidden = true
            }
        } else {
            
            UIView.animate(withDuration: 0.24) {
                self.errorLabel.isHidden = false
                self.gearWheelView.isHidden = true
            }
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    fileprivate func setupUI() {
        
        
        view.addSubview(sliderAngle)
        sliderAngle.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
        sliderAngle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        sliderAngle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        view.addSubview(sliderAngleLabel)
        sliderAngleLabel.bottomAnchor.constraint(equalTo: sliderAngle.topAnchor, constant: -20).isActive = true
        sliderAngleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        sliderAngleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        sliderAngleLabel.text = "Count: \(sliderAngle.value)"
        
        view.addSubview(sliderAngleHeight)
        sliderAngleHeight.bottomAnchor.constraint(equalTo: sliderAngleLabel.topAnchor, constant: -40).isActive = true
        sliderAngleHeight.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        sliderAngleHeight.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        view.addSubview(angleHeightLabel)
        angleHeightLabel.bottomAnchor.constraint(equalTo: sliderAngleHeight.topAnchor, constant: -20).isActive = true
        angleHeightLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        angleHeightLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        angleHeightLabel.text = "Height: \(sliderAngle.value)"
        
        
        view.addSubview(sliderRadius)
        sliderRadius.bottomAnchor.constraint(equalTo: angleHeightLabel.topAnchor, constant: -40).isActive = true
        sliderRadius.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        sliderRadius.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        view.addSubview(sliderRadiusLabel)
        sliderRadiusLabel.bottomAnchor.constraint(equalTo: sliderRadius.topAnchor, constant: -20).isActive = true
        sliderRadiusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        sliderRadiusLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        sliderRadiusLabel.text = "Height: \(sliderRadius.value)"
        
        
        view.addSubview(errorLabel)
        errorLabel.bottomAnchor.constraint(equalTo: sliderRadiusLabel.topAnchor, constant: -40).isActive = true
        errorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        errorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        errorLabel.isHidden = true
        
        
        view.addSubview(gearWheelView)
        gearWheelView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        gearWheelView.bottomAnchor.constraint(equalTo: sliderRadiusLabel.topAnchor, constant: -20).isActive = true
        gearWheelView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        gearWheelView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
       
        
        
        
       
        
    }
    
    
}


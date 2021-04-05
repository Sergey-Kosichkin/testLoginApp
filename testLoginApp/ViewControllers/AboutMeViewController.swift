//
//  AboutMeViewController.swift
//  testLoginApp
//
//  Created by Сергей Косичкин on 04.04.2021.
//

import UIKit

class AboutMeViewController: UIViewController {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var surnameLabel: UILabel!
    @IBOutlet var ageLabel: UILabel!
    @IBOutlet var skillLabel: UILabel!
    
    private var nameSwitch: Bool!
    private var surnameSwitch: Bool!
    private var ageSwitch: Bool!
    private var skillSwitch: Bool!
    
    private let confidential = "**********"
    private var alertSwitcher = false
    private var showAlert = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "\(Person.get(.name)) \(Person.get(.surname))"
        nameLabel.text = Person.get(.name)
        surnameLabel.text = Person.get(.surname)
        ageLabel.text = Person.get(.age)
        skillLabel.text = Person.get(.skill)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let settingsViewController = segue.destination as! SettingsViewController
        settingsViewController.view.backgroundColor = self.view.backgroundColor
        settingsViewController.redSlider.value = AppViewColor.share.color.redColor ?? 0.5
        settingsViewController.greenSlider.value = AppViewColor.share.color.greenColor ?? 0.5
        settingsViewController.blueSlider.value = AppViewColor.share.color.blueColor ?? 0.5
        
        settingsViewController.nameSwitch.isOn = nameSwitch ?? true
        settingsViewController.surnameSwitch.isOn = surnameSwitch ?? true
        settingsViewController.ageSwitch.isOn = ageSwitch ?? true
        settingsViewController.skillSwitch.isOn = skillSwitch ?? true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setGradientBackground()
        if alertSwitcher, showAlert {
            showAlert(with: "You can only once change App color!",
                      and: "To change next time you need new Log In session!")
            showAlert = false
        }
    }
    
    @IBAction func unwind(for segue: UIStoryboardSegue) {
        guard let setting = segue.source as? SettingsViewController else { return }
        nameSwitch = setting.nameSwitch.isOn
        surnameSwitch = setting.surnameSwitch.isOn
        ageSwitch = setting.ageSwitch.isOn
        skillSwitch = setting.skillSwitch.isOn
        
        if !nameSwitch {
            nameLabel.text = confidential
        } else {
            nameLabel.text = Person.get(.name)
        }
        
        if !surnameSwitch {
            surnameLabel.text = confidential
        } else {
            surnameLabel.text = Person.get(.surname)
        }
        
        if !ageSwitch {
            ageLabel.text = confidential
        } else {
            ageLabel.text = Person.get(.age)
        }
        
        if !skillSwitch {
            skillLabel.text = confidential
        } else {
            skillLabel.text = Person.get(.skill)
        }
        
        AppViewColor.share.color.redColor = setting.redSlider.value
        AppViewColor.share.color.greenColor = setting.greenSlider.value
        AppViewColor.share.color.blueColor = setting.blueSlider.value
        
        if !(setting.redSlider.isEnabled), !alertSwitcher{
            
    alertSwitcher = true
            
        } else if AppViewColor.share.color.change == 1 {
            AppViewColor.share.color.change = 0
        }
    
    }
}

extension UIViewController {
    
    func setGradientBackground() {
        
        if let _ = AppViewColor.share.color.redColor {
            let colorTop =  UIColor(red: CGFloat(AppViewColor.share.color.redColor ?? 0.5)/1.0,
                                    green: CGFloat(AppViewColor.share.color.greenColor ?? 0.5)/1.0,
                                    blue: CGFloat(AppViewColor.share.color.blueColor ?? 0.5)/1.0,
                                    alpha: 1.0).cgColor
            let colorBottom = UIColor(red: CGFloat((AppViewColor.share.color.redColor ?? 0.5) * 0.5)/1.0,
                                      green: CGFloat((AppViewColor.share.color.greenColor ?? 0.5) * 0.5)/1.0,
                                      blue: CGFloat((AppViewColor.share.color.blueColor ?? 0.5) * 0.5)/1.0,
                                      alpha: 1.0).cgColor
            
            
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [colorTop, colorBottom]
            gradientLayer.locations = [0.0, 1.0]
            gradientLayer.frame = self.view.bounds
            
            self.view.layer.insertSublayer(gradientLayer, at:0)
        }
    }
    
    
}

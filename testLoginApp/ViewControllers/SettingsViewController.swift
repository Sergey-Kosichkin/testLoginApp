//
//  SettingsViewController.swift
//  testLoginApp
//
//  Created by Сергей Косичкин on 04.04.2021.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var nameSwitch: UISwitch!
    @IBOutlet var surnameSwitch: UISwitch!
    @IBOutlet var ageSwitch: UISwitch!
    @IBOutlet var skillSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Settings"
        setGradientBackground()
        disableSlider()
    }
    
}

extension SettingsViewController {
    private func disableSlider() {
        if let check = AppViewColor.share.color.change {
            if check == 0 {
            redSlider.isEnabled = false
            greenSlider.isEnabled = false
            blueSlider.isEnabled = false
            }
        }
    }
    
}

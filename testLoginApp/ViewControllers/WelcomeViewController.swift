//
//  WelcomeViewController.swift
//  testLoginApp
//
//  Created by Сергей Косичкин on 31.03.2021.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet var welcomeLabel: UILabel!
    @IBOutlet var logoutButton: UIButton!
    
    var color: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        welcomeLabel.text = "Welcome, \(Person.get(.name)) \(Person.get(.surname))!"
        logoutButton.layer.cornerRadius = 10
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setGradientBackground()
    }
    
    @IBAction func logout() {
        dismiss(animated: true)
    }
}


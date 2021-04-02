//
//  WelcomeViewController.swift
//  testLoginApp
//
//  Created by Сергей Косичкин on 31.03.2021.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet var welcomeLabel: UILabel!
    
    var userName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        welcomeLabel.text = "Welcome, " + userName + " !"
        isModalInPresentation = true
       
    }
    
    @IBAction func logOutPressed() {
        dismiss(animated: true)
    }
}

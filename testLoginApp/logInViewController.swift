//
//  ViewController.swift
//  testLoginApp
//
//  Created by Сергей Косичкин on 30.03.2021.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var bottomConstraint: NSLayoutConstraint!
    @IBOutlet var allElementsStackView: UIStackView!
    
    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    @IBOutlet var loginButton: UIButton!
    
    private let userName = "User"
    private let userPassword = "Password"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.layer.cornerRadius = 10
        
        userNameTextField.delegate = self
        passwordTextField.delegate = self
        passwordTextField.enablesReturnKeyAutomatically = true
    
        bottomConstraint.constant =
            (self.view.bounds.height - allElementsStackView.bounds.height) / 2
        
    }
    
    override func viewWillLayoutSubviews() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handle(keyboardShowNotification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handle(keyboardHideNotification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil )
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(false)
    }
    
    
    @IBAction func logInPressed() {
        if userNameTextField.text == userName  {
            if passwordTextField.text == userPassword {
                
            }
        } else {
            showAlert(with: "Invalid login or password 🧐",
                      and: "Please, enter correct login and password!")
            passwordTextField.text = ""
            return
        }
    }
    
    @IBAction func forgotUserNamePressed() {
        showAlert(with: "Oops!", and: "Your name is \(userName) 😅")
        
    }
    
    @IBAction func forgotPasswordPressed() {
        showAlert(with: "Oops!", and: "Your password is \(userPassword) 😇")
    }
    
    
    @objc
    private func handle(keyboardShowNotification notification: Notification) {
        
        if let userInfo = notification.userInfo,
           let keyboardRectangle =
            userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            
            if bottomConstraint.constant < keyboardRectangle.height {
                bottomConstraint.constant = keyboardRectangle.height
            }
        }
    }
    
    @objc
    private func handle(keyboardHideNotification notification: Notification) {
        
        bottomConstraint.constant =
            (self.view.bounds.height - allElementsStackView.bounds.height) / 2
    }
    
    
}

extension ViewController {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameTextField {
            textField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        }
        if textField == passwordTextField {
            logInPressed()
        }
        return true
    }
    

    
    private func showAlert(with title: String, and message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in }
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

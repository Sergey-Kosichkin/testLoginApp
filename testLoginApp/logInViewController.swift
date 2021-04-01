//
//  ViewController.swift
//  testLoginApp
//
//  Created by Сергей Косичкин on 30.03.2021.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var bottomConstraint: NSLayoutConstraint!
    @IBOutlet var allElementsStackView: UIStackView!
    
    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    @IBOutlet var loginButton: UIButton!
    
    private let userName = "User"
    private let userPassword = "Password"
    
    // MARK: override func
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let welcomeVC = segue.destination as? WelcomeViewController else {
            return
        }
        welcomeVC.userName = userNameTextField.text
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(false)
    }
    
    
    // MARK: IBAction func
    @IBAction func unwind(for segue: UIStoryboardSegue) {
        userNameTextField.text = ""
        passwordTextField.text = ""
        
    }
    
    @IBAction func logInPressed() {
        if userNameTextField.text == userName,
           passwordTextField.text == userPassword {
            
            performSegue(withIdentifier: "welcomeMessage", sender: nil)
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
    
    // MARK: private func
    @objc
    private func handle(keyboardShowNotification notification: Notification) {
        if let userInfo = notification.userInfo,
           let keyboardRectangle =
            userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            
            if bottomConstraint.constant < keyboardRectangle.height {
                bottomConstraint.constant = keyboardRectangle.height
                animateConstraint()
            }
        }
    }
    
    @objc
    private func handle(keyboardHideNotification notification: Notification) {
        bottomConstraint.constant =
            (self.view.bounds.height - allElementsStackView.bounds.height) / 2
        animateConstraint()
    }
}

// MARK: extension
extension LoginViewController {
    
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
    
    
    private func animateConstraint() {
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
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

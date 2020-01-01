//
//  LoginViewController.swift
//  Dailies Task
//
//  Created by Malav's iMac on 9/9/19.
//  Copyright © 2019 agileimac-7. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {

    
    @IBOutlet weak private var txtPassword: UITextField!
    @IBOutlet weak private var txtEmail: UITextField!
    
    private var viewModel:LoginViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.viewModel = LoginViewModel(WithDelegate: self)
    }

    @IBAction func btnLoginClicked(_ sender: Any) {
        self.view.endEditing(true)
        self.viewModel.validateUser(withEmail: self.txtEmail.text, andPassword: self.txtPassword.text)
    }
    
    @IBAction func btnSignupClicked(_ sender: Any) {
        self.viewModel.createUser(withEmail: self.txtEmail.text, andPassword: self.txtPassword.text)
    }
}

extension LoginViewController:LoginViewModelProtocol{
    func userLoginSuccessfully() {
        UIAlertController.showAlert(withMessage: "User logged in Successfully", buttonAction: nil)
    }
    
    func loginFailed(withError error: String) {
        UIAlertController.showAlert(withMessage: error, buttonAction: nil)
    } 
}

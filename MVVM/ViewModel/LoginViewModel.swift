//
//  LoginViewModel.swift
//  MVVM
//
//  Created by AgileImac-5 on 30/12/19.
//  Copyright © 2019 AgileImac-5. All rights reserved.
//

import Foundation

typealias ValidationStatus = (status:Bool,errorMessage:String)

protocol LoginViewModelProtocol:class {
    func userLoginSuccessfully() -> Void
    func loginFailed(withError error:String) -> Void
}

class LoginViewModel: NSObject {
    weak var delegate:LoginViewModelProtocol?
    
    var firebaseHelper:FirebaseHelper?
    private var userInformation:UserInfo = UserInfo()
    
    override private init() {
        super.init()
        firebaseHelper = FirebaseHelper()
    }
    
    convenience init(WithDelegate delegate:LoginViewModelProtocol?) {
        self.init()
        self.delegate = delegate
    }
    
    func validateUser(withEmail email:String?,andPassword password:String?) -> Void{
        // Validate Email
        var validationResult = self.validate(email: email)
        guard validationResult.status == true else {
            self.delegate?.loginFailed(withError: validationResult.errorMessage)
            return
        }
        
        // Validate Password
        validationResult = self.validate(password: password)
        guard validationResult.status == true else {
            self.delegate?.loginFailed(withError: validationResult.errorMessage)
            return
        }
        
        self.loginUser(withEmail: email!, andPassword: password!)
    }
    
    func createUser(withEmail email:String?,andPassword password:String?) -> Void{
        // Validate Email
        var validationResult = self.validate(email: email)
        guard validationResult.status == true else {
            self.delegate?.loginFailed(withError: validationResult.errorMessage)
            return
        }
        
        // Validate Password
        validationResult = self.validate(password: password)
        guard validationResult.status == true else {
            self.delegate?.loginFailed(withError: validationResult.errorMessage)
            return
        }
        
        self.signUp(withEmail: email!, andPassword: password!)
    }
}

//MARK:- Server Communication
extension LoginViewModel{
    private func loginUser(withEmail email:String, andPassword password:String) -> Void{
        guard let firebaseHelper = self.firebaseHelper else{
            return
        }
        firebaseHelper.signIn(withEmail: email, andPassword: password) { [weak self](isSuccess, messageToDisplay) in
            if isSuccess{
                self?.userInformation.email = email
                self?.userInformation.password = password
                self?.delegate?.userLoginSuccessfully()
            }else{
                self?.delegate?.loginFailed(withError: messageToDisplay)
            }
        }
    }
    
    private func signUp(withEmail email:String, andPassword password:String) -> Void{
        guard let firebaseHelper = self.firebaseHelper else{
            return
        }
        firebaseHelper.signUp(withEmail: email, andPassword: password) { [weak self](isSuccess, messageToDisplay) in
            if isSuccess{
                self?.userInformation.email = email
                self?.userInformation.password = password
                self?.delegate?.userLoginSuccessfully()
            }else{
                self?.delegate?.loginFailed(withError: messageToDisplay)
            }
        }
    }
}

//MARK:- Validate user inputs
extension LoginViewModel{
    func validate(email:String?) -> ValidationStatus {
        guard let emailValue = email,emailValue.isEmpty == false else {
            return (false,AlertMessage.emailNameMissing)
        }
        if emailValue.isValidEmail() == false{
            return (false,AlertMessage.validEmail)
        }
        return (true,"")
    }
    
    func validate(password:String?) -> ValidationStatus {
        guard let passwordValue = password, passwordValue.isEmpty == false else {
            return (false,AlertMessage.passwordMissing)
        }
        return (true,"")
    }
}

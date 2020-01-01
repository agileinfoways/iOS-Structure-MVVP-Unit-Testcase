//
//  FirebaseHelper.swift
//  MVVM
//
//  Created by AgileImac-5 on 30/12/19.
//  Copyright © 2019 AgileImac-5. All rights reserved.
//

import UIKit
import Firebase

class FirebaseHelper: NSObject {
    
    typealias Completion = ((Bool,String) -> Void)
    
    func signUp(withEmail email:String,andPassword password:String,withCompletion completion:Completion?) -> Void{
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if authResult != nil{
                completion?(true,"")
            }else{
                completion?(false,error?.localizedDescription ?? "Failed to signup")
            }
        }
    }
    
    func signIn(withEmail email:String,andPassword password:String,withCompletion completion:Completion?) -> Void{
        Auth.auth().signIn(withEmail: email, password: password) {   authResult, error in
           if authResult != nil{
               completion?(true,"")
           }else{
               completion?(false,error?.localizedDescription ?? "Failed to signup")
           }
        }
    }
}

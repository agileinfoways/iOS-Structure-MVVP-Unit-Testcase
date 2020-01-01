//
//  LoginTestCases.swift
//  MVVMTests
//
//  Created by AgileImac-5 on 30/12/19.
//  Copyright © 2019 AgileImac-5. All rights reserved.
//

import XCTest
@testable import MVVM

class LoginTestCases: XCTestCase {

    var loginViewModel:LoginViewModel!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        loginViewModel = LoginViewModel(WithDelegate: nil)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        loginViewModel = nil
    }
    
    func testEmailValidation() -> Void{
        
        // Positive Testing
        let aryPositiveInputs:[String] = [
            "m@m.com",
        ]
        
        for object in aryPositiveInputs{
            XCTAssertTrue(loginViewModel.validate(email: object).status)
        }
        
        // Negative Testing
        let aryNegativeInputs:[String] = [
            "a",
            "a@",
            "@com"
        ]
        for object in aryNegativeInputs{
            XCTAssertFalse(loginViewModel.validate(email: object).status)
        }
    }
    
    func testPasswordValidation() -> Void{
        
        // Positive Testing
        let aryPositiveInputs:[String] = [
            "123456",
        ]
        
        for object in aryPositiveInputs{
            XCTAssertTrue(loginViewModel.validate(password: object).status,"\(String(describing: object)) is not valid password.")
        }
        
        // Negative Testing
        let aryNegativeInputs:[String?] = [
            "",
            nil
        ]
        for object in aryNegativeInputs{
            XCTAssertFalse(loginViewModel.validate(password: object).status,"\(String(describing: object)) is not valid password.")
        }
    }
    
    func testLoginAPICall() -> Void{
        let promise = expectation(description: "Login API Call Request")
        loginViewModel?.firebaseHelper?.signIn(withEmail: "m@m.com", andPassword: "123456", withCompletion: { (isSuccess, message) in
            XCTAssertFalse(isSuccess, "m@m.com is not valid user")
            promise.fulfill()
        })
        wait(for: [promise], timeout: 5.0)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            testLoginAPICall()
        }
    }
}

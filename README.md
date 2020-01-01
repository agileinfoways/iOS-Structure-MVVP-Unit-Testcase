# iOS-Structure-MVVP-Unit-Testcase

Why test cases? 

Each of the features implemented in your app should be tested whenever you make even the small change in your code or before releasing any build and one of the best ways to test that with automation is the test case.  

Since we are using MVVM, We will have our business logic written in a separate file so we can test the business logic easily and with the help of Apple's TestCase SDK, we can write our test cases in Xcode itself. 

How to write test cases?

We can write a test case for every function of the ViewModel file of the controller to ensure everything is working as expected.

We must test the app with positive and negative inputs to ensured that our method handles and behave correctly based on given inputs.  

We can write 2 types of Unit TestCase.
Unit TestCase
This test case will execute a particular method and execute it with different inputs and validate the outputs.
Performance TestCase
We can test the amount of time taken by executing a specific code. 
By this kind of test, we can check the amount of time taken by API to respond to specific inputs.
We can also set the baseline of response and check the API performance. 


XCTestCase class is used to create a test case that provides 2 methods which will be called every time our test case runs.
setUp
This method will be called before executing any test case.
tearDown
This method will be called after the execution of the test case finishes.
We can use the above methods to initialize and release variables that are used during the test case execution.


Code Coverage:
With the use of test cases, we can also validate whether each and every line we have written is useful or not.


MVVM Example

This project contains a very basic example of the login screen and test cases related to it.

This explains how to write test cases for the login screen based on different inputs from the user and how your app should behave. 

Project Structure
Assets
Fonts
Utility
List of classes that contains global methods for the app.
ViewController
For each screen, we will have a controller which will communicate with ViewModel and View
ViewModel
View Model class for each controller which will contain our business logics 
Model
Our model classes will contain the data from the API or Local Storage

Testcases Structure
Each controller will have its test cases file which will test the view model class of the controller. 
For each feature, there will be a positive and negative test case.

To run this Xcode project, please create a project with a firebase account first and make sure login with email and password is enable in that, after that add “GoogleService-Info.plist” to the Xcode project. 

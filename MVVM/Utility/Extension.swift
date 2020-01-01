//
//  Extension.swift
//  Dailies Task
//
//  Created by Malav's iMac on 9/9/19.
//  Copyright © 2019 agileimac-7. All rights reserved.
//

import Foundation
import UIKit

let tabBarTintColor: UIColor = UIColor.red
let navigationBarTitleColor: UIColor = UIColor.black
let navigationBarTintColor: UIColor = UIColor.orange
let navigationBarbarTintColor: UIColor = UIColor.red


import SDWebImage
extension UIImageView{
    func setImage(WithURL url:String) -> Void {
        self.sd_setImage(with: URL.init(string: url), placeholderImage: UIImage.init(named: "userprofile"), options: SDWebImageOptions.highPriority, context: nil)
    }
}


extension String{
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    func isValidPassword() -> Bool {
        let strPasswordValue = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        return strPasswordValue.count >= 8
    }
    
    func trimBlankSpace() -> String {
        return self.trimmingCharacters(in: .whitespaces)
    }
}

extension UIFont {
    var bold: UIFont { return withWeight(.bold) }
    var semibold: UIFont { return withWeight(.semibold) }
    
    private func withWeight(_ weight: UIFont.Weight) -> UIFont {
        var attributes = fontDescriptor.fontAttributes
        var traits = (attributes[.traits] as? [UIFontDescriptor.TraitKey: Any]) ?? [:]
        
        traits[.weight] = weight
        
        attributes[.name] = nil
        attributes[.traits] = traits
        attributes[.family] = familyName
        
        let descriptor = UIFontDescriptor(fontAttributes: attributes)
        
        return UIFont(descriptor: descriptor, size: pointSize)
    }
}

extension CGFloat{
    
    init?(_ str: String) {
        guard let float = Float(str) else { return nil }
        self = CGFloat(float)
    }
    
    
    func twoDigitValue() -> String {
        
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 0
        formatter.roundingMode = NumberFormatter.RoundingMode.halfUp //NumberFormatter.roundingMode.roundHalfUp
        
        
        //        let str : NSString = formatter.stringFromNumber(NSNumber(self))!
        let str = formatter.string(from: NSNumber(value: Double(self)))
        return str! as String;
    }
}

extension UIViewController {
    // get top most view controller helper method.
    static var topMostViewController : UIViewController {
        get {
            return UIViewController.topViewController(rootViewController: UIApplication.shared.keyWindow!.rootViewController!)
        }
    }
    
    fileprivate static func topViewController(rootViewController: UIViewController) -> UIViewController {
        guard rootViewController.presentedViewController != nil else {
            if rootViewController is UITabBarController {
                let tabbarVC = rootViewController as! UITabBarController
                let selectedViewController = tabbarVC.selectedViewController
                return UIViewController.topViewController(rootViewController: selectedViewController!)
            }
                
            else if rootViewController is UINavigationController {
                let navVC = rootViewController as! UINavigationController
                return UIViewController.topViewController(rootViewController: navVC.viewControllers.last!)
            }
            
            return rootViewController
        }
        
        return topViewController(rootViewController: rootViewController.presentedViewController!)
    }
}

public extension UIViewController {
    
    // MARK: - NavigationController Functions
    /// Set Appearance of UINavigationBar.
    func setAppearanceOfNavigationBar() {
        
        // Set navigationbar tittle,bar item , backgeound color
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = navigationBarTintColor
        self.navigationController?.navigationBar.barTintColor = navigationBarbarTintColor
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: navigationBarTitleColor,
                                       NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18.0) ]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key: AnyObject]
        
        // Set navigationbar back image(remove 'Back' from navagation)
        let backImage = UIImage(named: "back")?.withRenderingMode(.alwaysOriginal)
        self.navigationController?.navigationBar.backIndicatorImage = backImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        self.navigationController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        
        // Set status bar
        // self.setStatusBar()
        
        // Set image in navigation title
        // let imageViewTitle = UIImageView(image:ImageNamed(name: "skilliTextLogo"))
        // imageViewTitle.contentMode = .scaleAspectFit
        // self.navigationItem.titleView = imageViewTitle
    }
    
    /// Set Translucent of UINavigationBar.
    func setTranslucentOfNavigationBar() {
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    /// Hide bottom line from UINavigationBar.
//    func hideBottomLine() {
//        self.navigationController?.navigationBar.hideBottomHairline()
//    }
    
    /// Default push mathord.
    ///
    /// - Parameter viewController: your viewcontroller(String)
    func pushTo(_ viewController: String) {
        self.navigationController?.pushViewController((self.storyboard?.instantiateViewController(withIdentifier: viewController))!, animated: true)
    }
    
    /// Default pop mathord.
    func popTo() {
        self.navigationController?.popViewController(animated: true)
    }
    
    /// Default pop to root controller.
    func popToRoot() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    /// Default present methord
    ///
    /// - Parameter viewController: your viewcontroller(String)
    func presentTo(_ viewController: String) {
        let VC1 = self.storyboard?.instantiateViewController(withIdentifier: viewController)
        let navController = UINavigationController(rootViewController: VC1!)
        self.present(navController, animated: true, completion: nil)
    }
    
    /// Default dismiss methord
    func dismissTo() {
        self.navigationController?.dismiss(animated: true, completion: {})
    }
    
    // MARK: - NavigationBar Functions
    /// Remove navigation bar item
    func removeNavigationBarItem() {
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.rightBarButtonItem = nil
    }
    
    /// Show or hide navigation bar
    ///
    /// - Parameter isShow: Bool(true, false)
    func showNavigationBar(_ isShow: Bool) {
        self.navigationController?.isNavigationBarHidden = !isShow
    }
    
    // Right,left buttons
    /// Set left side Navigationbar button image.
    ///
    /// - Parameters:
    ///   - Name: set image name
    ///   - selector: return selector
    func setLeftBarButtonImage(_ name: String, selector: Selector) {
        if self.navigationController != nil {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: name), style: .plain, target: self, action: selector)
        }
    }
    
    /// Set left side Navigationbar button title.
    ///
    /// - Parameters:
    ///   - Name: button name
    ///   - selector: return selector
    func setLeftBarButtonTitle(_ name: String, selector: Selector) {
        if self.navigationController != nil {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: name, style: UIBarButtonItem.Style.plain, target: self, action: selector)
        }
    }
    
    /// Set right side Navigationbar button image.
    ///
    /// - Parameters:
    ///   - Name: set image name
    ///   - selector: return selector
    func setRightBarButtonImage(_ name: String, selector: Selector) {
        if self.navigationController != nil {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: name), style: .plain, target: self, action: selector)
        }
    }
    
    /// Set right side Navigationbar button title.
    ///
    /// - Parameters:
    ///   - Name: button name
    ///   - selector: return selector
    func setRightBarButtonTitle(_ name: String, selector: Selector) {
        if self.navigationController != nil {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: name, style: UIBarButtonItem.Style.plain, target: self, action: selector)
        }
    }
    
    /// Set right side two Navigationbar button image.
    ///
    /// - Parameters:
    ///   - btn1Name: First button image name
    ///   - selector1: Second button selector
    ///   - btn2Name: First button image name
    ///   - selector2: Second button selector
    func setTwoRightBarButtonImage(_ btn1Name: String, selector1: Selector, btn2Name: String, selector2: Selector) {
        if self.navigationController != nil {
            let barBtn1: UIBarButtonItem =  UIBarButtonItem(image: UIImage(named: btn1Name), style: .plain, target: self, action: selector1)
            let barBtn2: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: btn2Name), style: .plain, target: self, action: selector2)
            let buttons: [UIBarButtonItem] = [barBtn1, barBtn2]
            self.navigationItem.rightBarButtonItems = buttons
        }
    }
    
    /*
     func setRightBarButtonTitle(_ Name : String, selector : Selector) {
     
     if (self.navigationController != nil) {
     var barButton : UIBarButtonItem = UIBarButtonItem()
     barButton = UIBarButtonItem.init(title:Name.localized, style: UIBarButtonItemStyle.plain, target: self, action: selector)
     barButton.setTitleTextAttributes([ NSAttributedStringKey.font : UIFont.systemFont(ofSize: 18.0),
     NSAttributedStringKey.foregroundColor : UIColor.white,
     NSAttributedStringKey.backgroundColor:UIColor.white],
     for: UIControlState())
     self.navigationItem.rightBarButtonItem = barButton
     }
     }
     */
    
    // MARK: - TabBar Functions
       
    /// Check TabBar visible or not
    ///
    /// - Returns: Bool(true, false)
    func tabBarIsVisible() -> Bool {
        return self.tabBarController?.tabBar.frame.origin.y ?? 00 < UIScreen.main.bounds.height
    }
    
    /// Set AppearanceOfTabBar
    func setAppearanceOfTabBar() {
        self.tabBarController?.tabBar.isTranslucent = false
        self.tabBarController?.tabBar.tintColor = tabBarTintColor
    }
    
    /// Remove TabBar
    func removeTabBar() {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    // MARK: - UIViewController Functions
    /// Load your VieweContoller
    ///
    /// - Returns: self
    class func loadController(strStoryBoardName: String = "Main") -> Self {
        return instantiateViewControllerFromMainStoryBoard(strStoryBoardName: strStoryBoardName)
    }
    
    /// Set instantiat ViewController
    ///
    /// - Returns: self
    private class func instantiateViewControllerFromMainStoryBoard<T>(strStoryBoardName: String) -> T {
        guard let controller  = UIStoryboard(name: strStoryBoardName, bundle: nil).instantiateViewController(withIdentifier: String(describing: self)) as? T else {
            fatalError("Unable to find View controller with identifier")
        }
        return controller
    }
    
    /// Set status bar background color
    ///
    /// - Parameter color: your color
    func setStatusBarBackgroundColor(color: UIColor) {
        guard let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else { return }
        statusBar.backgroundColor = color
    }
    
    
    /// Return Top Controller from window
    static var topMostController: UIViewController {
        if let topVC = UIViewController.topViewController() {
            return topVC
        }
        else if let window =  UIApplication.shared.delegate!.window, let rootVC = window?.rootViewController {
            return rootVC
        }
        return UIViewController()
    }
    
    private class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
extension UIColor {
    
    static let themeColor:UIColor = UIColor.init(red: 55/255.0, green: 148/255.0, blue: 196/255.0, alpha: 1.0)
    
       static let redColor:UIColor = UIColor.init(red: 248/255.0, green: 90/255.0, blue: 84/255.0, alpha: 1.0)
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
    
    static func themeTintColor() -> UIColor {
        return UIColor.init(red: 55, green: 148, blue: 196)
    }
    
    
}


public extension UIAlertController {
    
    /// Show AlertController with message only
    ///
    /// - Parameters:
    ///   - message: set your message
    ///   - buttonTitles: set button array
    ///   - buttonAction: return button click block
    static func showAlert(withMessage message: String,
                                 buttonTitles: [String] = ["Okay"],
                                 buttonAction: ((_ index: Int) -> Void)?) {
        var appName = ""
        if let dict = Bundle.main.infoDictionary, let name = dict[kCFBundleNameKey as String] as? String {
            appName = name
        }
        
        self.showAlert(withTitle: appName,
                       withMessage: message,
                       buttonTitles: buttonTitles,
                       buttonAction: buttonAction)
        
    }
    
    /// Show AlertController with message and title
    ///
    /// - Parameters:
    ///   - title: set your title
    ///   - message: set your message
    ///   - buttonTitles: set button array
    ///   - buttonAction: return button click block
    static func showAlert(withTitle title: String,
                                 withMessage message: String,
                                 buttonTitles: [String],
                                 buttonAction: ((_ index: Int) -> Void)?) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for btn in buttonTitles {
            alertController.addAction(UIAlertAction(title: btn, style: .default, handler: { (_) in
                if let validHandler = buttonAction {
                    validHandler(buttonTitles.firstIndex(of: btn)!)
                }
            }))
        }
        // (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController?.present(alertController, animated: true, completion: nil)
        UIApplication.shared.delegate!.window!?.rootViewController?.present(alertController, animated: true, completion: nil)
        
    }
    
    /// Show Actionsheet with message only
    ///
    /// - Parameters:
    ///   - vc: where you display (UIViewController)
    ///   - message: your message
    ///   - buttons: button array
    ///   - canCancel: with cancel button
    ///   - completion: completion handler
    static func showActionSheetFromVC(_ viewController: UIViewController,
                                             andMessage message: String,
                                             buttons: [String],
                                             canCancel: Bool,
                                             completion: ((_ index: Int) -> Void)?) {
        var appName = ""
        if let dict = Bundle.main.infoDictionary, let name = dict[kCFBundleNameKey as String] as? String {
            appName = name
        }
        
        self.showActionSheetWithTitleFromVC(viewController,
                                            title: appName,
                                            andMessage: message,
                                            buttons: buttons,
                                            canCancel: canCancel,
                                            completion: completion)
    }
    
    /// Show Actionsheet with message and title
    ///
    /// - Parameters:
    ///   - vc: where you display (UIViewController)
    ///   - title: Alert title
    ///   - message: your message
    ///   - buttons: button array
    ///   - canCancel: with cancel button
    ///   - completion: completion handler
    static func showActionSheetWithTitleFromCurrentVC(_ message: String,
                                               buttons: [String],
                                               canCancel: Bool,
                                               completion: ((_ index: Int) -> Void)?) {
        
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        if let viewController = appDelegate.window?.rootViewController
        {
        var appName = ""
        if let dict = Bundle.main.infoDictionary, let name = dict[kCFBundleNameKey as String] as? String {
            appName = name
        }
        
        
        
        let alertController = UIAlertController(title: appName, message: message, preferredStyle: .actionSheet)
        
        for index in 0..<buttons.count {
            
            let action = UIAlertAction(title: buttons[index], style: .default, handler: { (_) in
                if let handler = completion {
                    handler(index)
                }
            })
            alertController.addAction(action)
        }
        
        if canCancel {
            let action = UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
                if let handler = completion {
                    handler(buttons.count)
                }
            })
            
            alertController.addAction(action)
        }
        
        if UIDevice.isIpad {
            
            if viewController.view != nil {
                alertController.popoverPresentationController?.sourceView = viewController.view
                alertController.popoverPresentationController?.sourceRect = CGRect(x: 0, y: (viewController.view?.frame.size.height)!, width: 1.0, height: 1.0)
            } else {
                alertController.popoverPresentationController?.sourceView = UIApplication.shared.delegate!.window!?.rootViewController!.view
                alertController.popoverPresentationController?.sourceRect = CGRect(x: 0, y: 0, width: 1.0, height: 1.0)
            }
        }
        viewController.present(alertController, animated: true, completion: nil)
        }
    }
    
    /// Show Actionsheet with message and title
    ///
    /// - Parameters:
    ///   - vc: where you display (UIViewController)
    ///   - title: Alert title
    ///   - message: your message
    ///   - buttons: button array
    ///   - canCancel: with cancel button
    ///   - completion: completion handler
    static func showActionSheetWithTitleFromVC(_ viewController: UIViewController,
                                                      title: String,
                                                      andMessage message: String,
                                                      buttons: [String],
                                                      canCancel: Bool,
                                                      completion: ((_ index: Int) -> Void)?) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        for index in 0..<buttons.count {
            
            let action = UIAlertAction(title: buttons[index], style: .default, handler: { (_) in
                if let handler = completion {
                    handler(index)
                }
            })
            alertController.addAction(action)
        }
        
        if canCancel {
            let action = UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
                if let handler = completion {
                    handler(buttons.count)
                }
            })
            
            alertController.addAction(action)
        }
        
        if UIDevice.isIpad {
            
            if viewController.view != nil {
                alertController.popoverPresentationController?.sourceView = viewController.view
                alertController.popoverPresentationController?.sourceRect = CGRect(x: 0, y: (viewController.view?.frame.size.height)!, width: 1.0, height: 1.0)
            } else {
                alertController.popoverPresentationController?.sourceView = UIApplication.shared.delegate!.window!?.rootViewController!.view
                alertController.popoverPresentationController?.sourceRect = CGRect(x: 0, y: 0, width: 1.0, height: 1.0)
            }
        }
        viewController.present(alertController, animated: true, completion: nil)
    }
}


public extension UIDevice {
    
    enum DeviceType: Int {
        case iPhone4or4s
        case iPhone5or5s
        case iPhone6or6s
        case iPhone6por6sp
        case iPhoneXorXs
        case iPhoneXrorXsMax
        case iPad
    }
    
    /// Check Decide type
    static var deviceType: DeviceType {
        // Need to match width also because if device is in portrait mode height will be different.
        if UIDevice.screenHeight == 480 || UIDevice.screenWidth == 480 {
            return DeviceType.iPhone4or4s
        } else if UIDevice.screenHeight == 568 || UIDevice.screenWidth == 568 {
            return DeviceType.iPhone5or5s
        } else if UIDevice.screenHeight == 667 || UIDevice.screenWidth == 667 {
            return DeviceType.iPhone6or6s
        } else if UIDevice.screenHeight == 736 || UIDevice.screenWidth == 736 {
            return DeviceType.iPhone6por6sp
        } else if UIDevice.screenHeight == 812 || UIDevice.screenWidth == 812 {
            return DeviceType.iPhoneXorXs
        } else if UIDevice.screenHeight == 896 || UIDevice.screenWidth == 896 {
            return DeviceType.iPhoneXorXs
        } else {
            return DeviceType.iPad
        }
    }
    
    /// Check device is Portrait mode
    static var isPortrait: Bool {
        return UIDevice.current.orientation.isPortrait
    }
    
    /// Check device is Landscape mode
    static var isLandscape: Bool {
        return UIDevice.current.orientation.isLandscape
    }
    
    // MARK: - Device Screen Height
    
    /// Return screen height
    static var screenHeight: CGFloat {
        return UIScreen.main.bounds.size.height
    }
    
    // MARK: - Device Screen Width
    
    /// Return screen width
    static var screenWidth: CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    /// Return screen size
    static var screenSize: CGSize {
        return UIScreen.main.bounds.size
    }
    
    /// Return device model name
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }
    
    // MARK: - Device is iPad
    /// Return is iPad device
    static var isIpad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    
    // MARK: - Device is iPhone
    
    /// Return is iPhone device
    static var isIphone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }
}


extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
extension UIImage {
    func resizeImage(_ dimension: CGFloat, opaque: Bool, contentMode: UIView.ContentMode = .scaleAspectFit) -> UIImage {
        var width: CGFloat
        var height: CGFloat
        var newImage: UIImage
        
        let size = self.size
        let aspectRatio =  size.width/size.height
        
        switch contentMode {
        case .scaleAspectFit:
            if aspectRatio > 1 {                            // Landscape image
                width = dimension
                height = dimension / aspectRatio
            } else {                                        // Portrait image
                height = dimension
                width = dimension * aspectRatio
            }
            
        default:
            fatalError("UIIMage.resizeToFit(): FATAL: Unimplemented ContentMode")
        }
        
        if #available(iOS 10.0, *) {
            let renderFormat = UIGraphicsImageRendererFormat.default()
            renderFormat.opaque = opaque
            let renderer = UIGraphicsImageRenderer(size: CGSize(width: width, height: height), format: renderFormat)
            newImage = renderer.image {
                (context) in
                self.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
            }
        } else {
            UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: height), opaque, 0)
            self.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
            newImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
        }
        
        return newImage
    }
}

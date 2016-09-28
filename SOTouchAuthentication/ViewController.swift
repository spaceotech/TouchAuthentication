//
//  ViewController.swift
//  SOTouchAuthentication
//
//  Created by Hitesh on 9/28/16.
//  Copyright © 2016 myCompany. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //Create a context
        let authenticationContext = LAContext()
        
        var error:NSError?
        
        //Check if device have Biometric sensor
        let isValidSensor : Bool = authenticationContext.canEvaluatePolicy(.DeviceOwnerAuthentication, error: &error)
        
        if isValidSensor {
            //Device have BiometricSensor
            //It Supports TouchID
            authenticationContext.evaluatePolicy(
                .DeviceOwnerAuthenticationWithBiometrics,
                localizedReason: "Authenticate",
                reply: { [unowned self] (success, error) -> Void in
                    
                    if( success ) {
                        //Fingerprint recognized
                        self.goToNextVC()
                        
                    } else {
                        //If not recognized then
                        if let error = error {
                            let strMessage = self.errorMessage(error.code)
                            self.showAlertWithTitle("Error", message: strMessage)
                            
                        }
                        
                    }
                })
        } else {
            let strMessage = self.errorMessage(error!.code)
            self.showAlertWithTitle("Error", message: strMessage)
        }
    }

    //MARK: Show Alert
    func showAlertWithTitle( title:String, message:String ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        let actionOk = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alert.addAction(actionOk)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    //MARK: TouchID error
    func errorMessage(errorCode:Int) -> String{
        
        var strMessage = ""
        
        switch errorCode {
        case LAError.AuthenticationFailed.rawValue:
            strMessage = "Authentication Failed"
            
        case LAError.UserCancel.rawValue:
            strMessage = "User Cancel"
            
        case LAError.UserFallback.rawValue:
            strMessage = "User Fallback"
            
        case LAError.SystemCancel.rawValue:
            strMessage = "System Cancel"
            
        case LAError.PasscodeNotSet.rawValue:
            strMessage = "Passcode Not Set"
            
        case LAError.TouchIDNotAvailable.rawValue:
            strMessage = "TouchI DNot Available"
            
        case LAError.TouchIDNotEnrolled.rawValue:
            strMessage = "TouchID Not Enrolled"
            
        case LAError.TouchIDLockout.rawValue:
            strMessage = "TouchID Lockout"
            
        case LAError.AppCancel.rawValue:
            strMessage = "App Cancel"
            
        case LAError.InvalidContext.rawValue:
            strMessage = "Invalid Context"
            
        default:
            strMessage = "Some error found"
            
        }
        
        return strMessage
        
    }
    
    func goToNextVC() {
        let objHomeVC = self.storyboard?.instantiateViewControllerWithIdentifier("HomeVCID")
        self.presentViewController(objHomeVC!, animated: true, completion: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


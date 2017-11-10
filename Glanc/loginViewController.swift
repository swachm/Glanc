//
//  ViewController.swift
//  Glanc
//
//  Created by Manmeet Swach on 2016-01-21.
//  Copyright © 2016 Swach. All rights reserved.
//

import UIKit
import EZLoadingActivity   //Activity Bar
import Alamofire
    
class loginViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: Login Screen variables
    @IBOutlet weak var loginSignupLogo: UIImageView!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
   // @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var showSplashScreen: UIButton!
    var forgotPasswordTextField: UITextField!
    
    @IBOutlet weak var newLoginSignupLogoWidth: NSLayoutConstraint!
    @IBOutlet weak var newLoginSignupLogoHeight: NSLayoutConstraint!
    @IBOutlet weak var newLoginSignupLogoYPosition: NSLayoutConstraint!
    
    var serverOutput: NSDictionary = [:]
    var userID: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // self.navigationController!.interactivePopGestureRecognizer!.delegate = nil //used to activate back swipe gesture
        
        //To override the spacebar return function to nil
        usernameField.delegate = self
        passwordField.delegate = self
        
        //Hidding all UI items till the start animation is done playing
        self.usernameField.alpha = 0
        self.passwordField.alpha = 0
        self.loginButton.alpha = 0
        //self.signupButton.alpha = 0
        self.forgotPasswordButton.alpha = 0
        self.showSplashScreen.alpha = 0
        
        //Adding the Underline to both username and password textbox
       usernameField.underlinedTextboxSelected()
       passwordField.underlinedTextboxNotSelected()
        
        //Placeholders and font for username and password
        usernameField.attributedPlaceholder = NSAttributedString (string: "username", attributes: [NSForegroundColorAttributeName: UIColor.white])
        passwordField.attributedPlaceholder = NSAttributedString (string: "password", attributes: [NSForegroundColorAttributeName: UIColor.white])
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print (loginSignupLogo.frame.origin.x)
        print (loginSignupLogo.frame.origin.y)
        
        newLoginSignupLogoWidth.constant = 120
        newLoginSignupLogoHeight.constant = 120
        newLoginSignupLogoYPosition.constant = 28
        
        
        UIView.animateKeyframes(withDuration: 1, delay: 0, options: [], animations: {
            //Show all the UI Item
            self.view.layoutIfNeeded()
            },
                                            completion: nil)
        
        UIView.animateKeyframes(withDuration: 0.4, delay: 1, options: [], animations: {
            //Show all the UI Items
            self.usernameField.alpha = 1.0
            self.passwordField.alpha = 1.0
            self.loginButton.alpha = 1.0
            //self.signupButton.alpha = 1.0
            self.forgotPasswordButton.alpha = 1.0
            self.showSplashScreen.alpha = 1.0
            },
            completion: nil)
        
        self.usernameField.becomeFirstResponder()
        
        print (loginSignupLogo.frame.origin.x)
        print (loginSignupLogo.frame.origin.y)
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.underlinedTextboxSelected()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.underlinedTextboxNotSelected()
    }
    
    
    func alertForgotPasswordTextField (_ forgotPasswordTextField: UITextField){
        forgotPasswordTextField.delegate = self
        forgotPasswordTextField.placeholder = "Enter an Email"
    }
    
    @IBAction func showSplashScreen(_ sender: AnyObject) {
        let modalStyle = UIModalTransitionStyle.crossDissolve
        let showSignupBoard = (self.storyboard?.instantiateViewController(withIdentifier: "splashScreen"))! as UIViewController
        showSignupBoard.modalTransitionStyle = modalStyle
        self.present(showSignupBoard, animated: false, completion: nil)
    }

    
    
    @IBAction func forgotPassword(_ sender: AnyObject) {
        let alrtUserforEmptyUsernamePassword: UIAlertController = UIAlertController (title:"Forgot Password", message:  "We will email you a link to reset your password", preferredStyle: .alert)
        
        alrtUserforEmptyUsernamePassword.addTextField(configurationHandler: alertForgotPasswordTextField)
        
        let cancelAction: UIAlertAction = UIAlertAction (title: "Cancel", style: .default, handler: nil)
        alrtUserforEmptyUsernamePassword.addAction(cancelAction)
        
        let okAction: UIAlertAction = UIAlertAction (title: "OK", style: .default, handler: nil)
        alrtUserforEmptyUsernamePassword.addAction(okAction)

        self.present(alrtUserforEmptyUsernamePassword, animated: true, completion: nil)
    }
    
    @IBAction func loginUser(_ sender: AnyObject) {
        let username = self.usernameField.text!
        let password = self.passwordField.text!
        
        if (password.isEmpty){
            produceAlert("password.")
        }else if (username.isEmpty){
            produceAlert("username.")
        }else{
            self.sendServerRequest(username, password: password)
        }
    }
    
    //MARK: Signup Screen Actions
    func sendServerRequest(_ username: String, password: String){
        Alamofire.request(.POST, "http://ec2-54-186-212-78.us-west-2.compute.amazonaws.com/login.php", parameters: ["username": username, "password":password])
            .validate()
            .response { request, response, data, error in
                print(data)
                self.serverOutput = self.parseServerJson(data!)

                self.updateAndProceed()
        }
    }
    
    func parseServerJson (_ data: Data) -> NSDictionary{
        var output: NSDictionary = [:]
        do{
            output = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
            self.userID = output["userID"] as! Int
            print (userID)
        } catch {
            print ("unparsable")
        }
        return output
    }
    
    func updateAndProceed(){
        let defaults = UserDefaults.standard
        
        if (userID == 0){
            defaults.removeObject(forKey: "username")
            defaults.removeObject(forKey: "userID")
            defaults.set(false, forKey: "isLoggedIn")
            produceLoginUnsuccessAlert()
        }else{
            defaults.set(usernameField.text!, forKey: "username")
            defaults.set(userID, forKey: "userID")
            
            
            //defaults.setBool(true, forKey: "isLoggedIn")
            
            produceLoginSuccessAlert()
            
            let modalStyle = UIModalTransitionStyle.crossDissolve
            let showUserTabBar = (self.storyboard?.instantiateViewController(withIdentifier: "requestAccess"))!
            showUserTabBar.modalTransitionStyle = modalStyle
            self.present(showUserTabBar, animated: true, completion: nil)
        }
    }
    
    
    //Dismiss Keyboard when screen is touched anywhere
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (string == " ") {
            return false
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.usernameField{
            self.passwordField.becomeFirstResponder()
        }
        return true
    }
    
    func produceAlert(_ errorEntry: String){
        let message: String = "Please enter your " + errorEntry
        
        let alrtUserforEmptyUsernamePassword: UIAlertController = UIAlertController (title:"Login", message:  message, preferredStyle: .alert)
        let okAction: UIAlertAction = UIAlertAction (title: "OK", style: .default, handler: nil)
        alrtUserforEmptyUsernamePassword.addAction(okAction)
        self.present(alrtUserforEmptyUsernamePassword, animated: true, completion: nil)
    }
    
    func produceLoginUnsuccessAlert(){
        let message: String = "Login was unsuccessful"
        
        let alrtUserforEmptyUsernamePassword: UIAlertController = UIAlertController (title:"Login Unsuccessful", message:  message, preferredStyle: .alert)
        let okAction: UIAlertAction = UIAlertAction (title: "OK", style: .default, handler: nil)
        alrtUserforEmptyUsernamePassword.addAction(okAction)
        self.present(alrtUserforEmptyUsernamePassword, animated: true, completion: nil)
    }
    
    func produceLoginSuccessAlert(){
        
        
        
        
    }
}


//
//  ViewController.swift
//  Glanc
//
//  Created by Manmeet Swach on 2016-01-28.
//  Copyright © 2016 Swach. All rights reserved.
//

import UIKit
import EZLoadingActivity
import Alamofire

class signupViewController: UIViewController, UITextFieldDelegate {

    //MARK: Signup Screen Variables
    @IBOutlet weak var usernameFieldSignup: UITextField!
    @IBOutlet weak var emailFieldSignup: UITextField!
    @IBOutlet weak var passwordFieldSignup: UITextField!
    @IBOutlet weak var signupButtonSignup: UIButton!
    @IBOutlet weak var alreadyGotAnAccount: UIButton!
    @IBOutlet weak var appLogoSignup: UIImageView!
    @IBOutlet weak var showSplashScreen: UIButton!
    
    @IBOutlet weak var newAppLogoSignupWidth: NSLayoutConstraint!
    @IBOutlet weak var newAppLogoSignupHeight: NSLayoutConstraint!
    @IBOutlet weak var newAppLogoSignupYPosition: NSLayoutConstraint!
    
    var serverOutput: NSDictionary = [:]
    var userID: Int = 0
    var status: String = ""
    var countryCode: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //To override the spacebar return function to nil
        usernameFieldSignup.delegate = self
        passwordFieldSignup.delegate = self
        emailFieldSignup.delegate = self

        // Do any additional setup after loading the view.
        self.usernameFieldSignup.alpha = 0
        self.emailFieldSignup.alpha = 0
        self.passwordFieldSignup.alpha = 0
        self.signupButtonSignup.alpha = 0
        self.alreadyGotAnAccount.alpha = 0
        
        // Underline the textbox
        self.usernameFieldSignup.underlinedTextboxSelected()
        self.emailFieldSignup.underlinedTextboxNotSelected()
        self.passwordFieldSignup.underlinedTextboxNotSelected()
        
        //Placeholders and font for username and password
        usernameFieldSignup.attributedPlaceholder = NSAttributedString (string: "username", attributes: [NSForegroundColorAttributeName: UIColor.white])
        emailFieldSignup.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSForegroundColorAttributeName: UIColor.white])
        passwordFieldSignup.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSForegroundColorAttributeName: UIColor.white])
        
        signupButtonSignup.layer.cornerRadius = 5
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        newAppLogoSignupWidth.constant = 120
        newAppLogoSignupHeight.constant = 120
        newAppLogoSignupYPosition.constant = 28
        
        UIView.animateKeyframes(withDuration: 1, delay: 0, options: [], animations: {
            self.view.layoutIfNeeded()
            }, completion: nil)
        
        UIView.animateKeyframes(withDuration: 0.4, delay: 1, options: [], animations: {
            //Show all the UI Items
            self.usernameFieldSignup.alpha = 1.0
            self.emailFieldSignup.alpha = 1.0
            self.passwordFieldSignup.alpha = 1.0
            self.signupButtonSignup.alpha = 1.0
            self.alreadyGotAnAccount.alpha = 1.0
            },
            completion: nil)
        
        self.usernameFieldSignup.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //MARK: All the textfield delegates ------------------
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.underlinedTextboxSelected()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.underlinedTextboxNotSelected()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (string == " ") {
            return false
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.usernameFieldSignup{
            self.emailFieldSignup.becomeFirstResponder()
        }
        else if textField == self.emailFieldSignup{
            self.passwordFieldSignup.becomeFirstResponder()
        }
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    func isValidEmail(_ testStr:String) -> Bool {
        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func sendServerRequest(_ username: String, password: String, email: String){
        Alamofire.request(.POST, "http://ec2-54-186-212-78.us-west-2.compute.amazonaws.com/signup.php", parameters: ["username": username, "password":password, "email":email])
            .validate()
            .response { request, response, data, error in
                //  print(request)
                //  print(response)
                // print(data)
                //   print(error)
                self.serverOutput = self.parseServerJson(data!)
                self.recordData()
                self.shallWeProceed()
        }
    }
    
    func parseServerJson (_ data: Data) -> NSDictionary{
        //print (data)
        var output: NSDictionary = [:]
        do{
            output = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
            userID = output["userID"] as! Int
            status = output["status"] as! String
            countryCode  = output["countryCode"] as! String
            
        } catch {
            print ("unparsable")
        }
        return output
    }
    
    func recordData(){
        userID = serverOutput["userID"] as! Int
        status = serverOutput["status"] as! String
        countryCode  = serverOutput["countryCode"] as! String
    }
    
    
    func shallWeProceed(){
        print(userID)
        print (status)
        print (countryCode)
        if (status == "usernameExists"){
            produceExistsAlert("Username", title: "Username Exists")
        }else if (status == "emailExists"){
            produceExistsAlert("Email", title: "Email Exists")
        }else{
            createUser()
        }
    }
    
    @IBAction func signupButtonSignup(_ sender: AnyObject) {
        
        
         let username: String = self.usernameFieldSignup.text!
         let password:String = self.passwordFieldSignup.text!
         let email:String = self.emailFieldSignup.text!
        
        
        if (password.characters.count < 4){
            produceAlert("password", email: false)
        }else if (username.characters.count < 4){
            produceAlert("username", email: false)
        }else{
            sendServerRequest(username, password: password, email: email)
        }
    }
    
    func createUser(){
        storeDataOnIphone()
        showPhoneScreen()
    }
    
    
    func showPhoneScreen(){
        let signinLogedinViewController = (self.storyboard?.instantiateViewController(withIdentifier: "phoneNumber"))!
        self.present(signinLogedinViewController, animated: true, completion: nil)
    }
    
    func storeDataOnIphone(){
        let defaults = UserDefaults.standard
        defaults.set(usernameFieldSignup.text!, forKey: "username")
        defaults.set(userID, forKey: "userID")
        defaults.set(true, forKey: "isLoggedIn")
    }
    
    @IBAction func showSplashScreen(_ sender: AnyObject) {
        let modalStyle = UIModalTransitionStyle.crossDissolve
        let showSignupBoard = (self.storyboard?.instantiateViewController(withIdentifier: "splashScreen"))! as UIViewController
        showSignupBoard.modalTransitionStyle = modalStyle
        self.present(showSignupBoard, animated: false, completion: nil)
    }
    
    func produceAlert(_ errorEntry: String, email: Bool){
        var message: String
        if (email){
            message = "Please enter a valid email."
        }else{
            message = errorEntry + " must be 4 characters long."
        }
        
        let alrtUserforEmptyUsernamePassword: UIAlertController = UIAlertController (title:"Signup", message:  message, preferredStyle: .alert)
        let okAction: UIAlertAction = UIAlertAction (title: "OK", style: .default, handler: nil)
        alrtUserforEmptyUsernamePassword.addAction(okAction)
        self.present(alrtUserforEmptyUsernamePassword, animated: true, completion: nil)
    }
    
    func produceExistsAlert(_ errorEntry: String, title: String){
        var message: String

        message = errorEntry + " already exists please use forgot password"
        let alrtUserforEmptyUsernamePassword: UIAlertController = UIAlertController (title:title, message:  message, preferredStyle: .alert)
        let okAction: UIAlertAction = UIAlertAction (title: "OK", style: .default, handler: nil)
        alrtUserforEmptyUsernamePassword.addAction(okAction)
        self.present(alrtUserforEmptyUsernamePassword, animated: true, completion: nil)
    }
    
}

//
//  SplashAnimationViewController.swift
//  Glanc
//
//  Created by Manmeet Swach on 2016-01-28.
//  Copyright © 2016 Swach. All rights reserved.
//

import UIKit

class SplashAnimationViewController: UIViewController {
    @IBOutlet weak var splashLogo: UIImageView!
    @IBOutlet weak var welcomeToSling: UILabel!
    @IBOutlet weak var GetRealTImeUpdates: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var newLogoWidth: NSLayoutConstraint!
    @IBOutlet weak var newLogoHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.splashLogo.alpha = 1
        self.welcomeToSling.alpha = 0
        self.GetRealTImeUpdates.alpha = 0
        self.loginButton.alpha = 0
        self.signupButton.alpha = 0
        
        loginButton.layer.cornerRadius = 5
        signupButton.layer.backgroundColor = UIColor (red: 46/255, green: 177/255, blue: 209/255, alpha: 1.0).cgColor
        signupButton.layer.borderColor = UIColor (red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).cgColor
        signupButton.layer.cornerRadius = 5
        signupButton.layer.borderWidth = 2
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        
        newLogoWidth.constant = 160
        newLogoHeight.constant = 160
        
        UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: [], animations: {
            self.splashLogo.alpha = 1.0
                       },
            completion: nil)
        
        UIView.animateKeyframes(withDuration: 1.5, delay: 0.5, options: [], animations: {
            self.view.layoutIfNeeded()
            },
            completion: nil)
        
        newLogoWidth.constant = 180
        newLogoHeight.constant = 180
        
        UIView.animateKeyframes(withDuration: 1.5, delay: 2.0, options: [], animations: {
            self.view.layoutIfNeeded()
            },
            completion: nil)
        
        
        //Show the button and the app slogan
        UIView.animateKeyframes(withDuration: 1.5, delay: 3, options: [], animations: {
            //Show all the UI Items
            self.welcomeToSling.alpha = 1
            self.GetRealTImeUpdates.alpha = 1
            self.loginButton.alpha = 1
            self.signupButton.alpha = 1
            },
            completion: nil)
        
        print (splashLogo.frame.origin.x)
        print (splashLogo.frame.origin.y)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changeViewToLogin(_ sender: AnyObject) {
        self.splashLogo.alpha = 0
        let modalStyle = UIModalTransitionStyle.crossDissolve
        let showLoginBoard = (self.storyboard?.instantiateViewController(withIdentifier: "loginBoard"))!
        showLoginBoard.modalTransitionStyle = modalStyle
        self.present(showLoginBoard, animated: false, completion: nil)
    }
    
    @IBAction func changeViewToSignup(_ sender: AnyObject) {
        self.splashLogo.alpha = 0
        let modalStyle = UIModalTransitionStyle.coverVertical
        let showUserTabBar = (self.storyboard?.instantiateViewController(withIdentifier: "SignupBoard"))!
        showUserTabBar.modalTransitionStyle = modalStyle
        self.present(showUserTabBar, animated: false, completion: nil)
    }

}

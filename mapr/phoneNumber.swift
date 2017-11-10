//
//  phoneNumber.swift
//  Glanc
//
//  Created by Manmeet Swach on 2016-05-21.
//  Copyright © 2016 Swach. All rights reserved.
//

import UIKit

class phoneNumber: UIViewController {
    @IBOutlet weak var countryCode: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countryCode.underlinedTextboxSelected()
        phoneNumber.underlinedTextboxSelected()
        nextButton.layer.cornerRadius = 5
        phoneNumber.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showUserTabbar(){
        let modalStyle = UIModalTransitionStyle.crossDissolve
        let showUserTabBar = (self.storyboard?.instantiateViewController(withIdentifier: "requestAccess"))!
        showUserTabBar.modalTransitionStyle = modalStyle
        self.present(showUserTabBar, animated: false, completion: nil)
    }
    
    func showAlert (){
        
    }
    
    func registerPhoneNumber()->Bool{
        return true //update when server implemented
    }
    
    @IBAction func nextButton(_ sender: AnyObject) {
        if registerPhoneNumber() == true {
            showUserTabbar()
        }
        else{
            showAlert()
        }
    }

    @IBAction func popView(_ sender: AnyObject) {
        view.endEditing(true)
        self.dismiss(animated: true, completion: nil)
    }
}

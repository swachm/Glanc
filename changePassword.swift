//
//  changePassword.swift
//  Glanc
//
//  Created by Manmeet Swach on 2016-06-09.
//  Copyright © 2016 Swach. All rights reserved.
//

import UIKit

class changePassword: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var oldPassword: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var retypePassword: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.oldPassword.delegate = self
        self.newPassword.delegate = self
        self.retypePassword.delegate = self
        
        oldPassword.passwordLine()
        newPassword.passwordLine()
        retypePassword.passwordLine()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if (textField == oldPassword){
            
        }else if (textField == newPassword){
            
        }else{
            
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

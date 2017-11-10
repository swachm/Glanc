//
//  changeEmail.swift
//  
//
//  Created by Manmeet Swach on 2016-04-09.
//
//

import UIKit
import Alamofire

class changeEmail: UIViewController, UITextViewDelegate {

    @IBOutlet weak var changeEmailTextField : UITextView!
    var serverOutput: NSDictionary = [:]
    var currentEmail: String = ""
    var serverResponse: String = ""
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.changeEmailTextField.delegate = self
        
        let defaults = UserDefaults.standard
        let userID: Int = defaults.value(forKey: "userID") as! Int
        
        self.getEmail(userID)
        self.changeEmailTextField.text = currentEmail
        self.changeEmailTextField!.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getEmail(_ userID: Int){
//        Alamofire.request(.POST, "http://ec2-54-186-212-78.us-west-2.compute.amazonaws.com/readEmailAddress.php", parameters: ["userID": userID])
//            .validate(statusCode: 200..<300)
//            .validate(contentType: ["application/json"])
//            .responseData { response in
//                switch response.result {
//                case .success:
//                    print("Validation Successful")
//                case .failure(let error):
//                    self.serverOutput = self.parseServerJson(data!)
//                }
//        }
    }
    
    func parseServerJson (_ data: Data) -> NSDictionary{
        var output: NSDictionary = [:]
        do{
            output = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
            self.currentEmail = output["email"] as! String
            self.changeEmailTextField.text = self.currentEmail
        } catch {
            print ("unparsable")
        }
        return output
    }
    
    //Change email when the view is about to disappear
    override func viewWillDisappear(_ animated: Bool) {
        let userID: Int = defaults.value(forKey: "userID") as! Int
        let newEmail = self.changeEmailTextField!.text
        if (newEmail != currentEmail){
            setEmail(userID,newEmail: newEmail!)
        }
    }
    
    func setEmail(_ userID: Int, newEmail: String){
//        Alamofire.request(.POST, "http://ec2-54-186-212-78.us-west-2.compute.amazonaws.com/updateEmail.php", parameters: ["userID": userID, "newEmail": newEmail])
//            .validate()
//            .response { request, response, data, error in
//        }
    }
}

//
//  requestAccessViewController.swift
//  Glanc
//
//  Created by Manmeet Swach on 2016-05-29.
//  Copyright © 2016 Swach. All rights reserved.
//

import UIKit
import Contacts
import CoreLocation



class requestAccessViewController: UIViewController {
    @IBOutlet weak var pushNotification: UIButton!
    @IBOutlet weak var locationsServices: UIButton!
    @IBOutlet weak var contactAccess: UIButton!

    var locManager = CLLocationManager()
    var countForButtonPress: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pushNotification.addBorderToButton()
        locationsServices.addBorderToButton()
        contactAccess.addBorderToButton()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pushNotifications(_ sender: AnyObject) {
        countForButtonPress = countForButtonPress+1
        pushNotification.setImage(UIImage(named: "rightArrowCheckMark.png"), for: UIControlState())
        checkIfAllAccessGranted()
    }

    @IBAction func locationServices(_ sender: AnyObject) {
        locManager.desiredAccuracy = kCLLocationAccuracyBest
        locManager.requestAlwaysAuthorization()
        locManager.stopUpdatingLocation()
        locManager.stopUpdatingHeading()
        
        if( CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways){
            locationsServices.setImage(UIImage(named: "rightArrowCheckMark.png"), for: UIControlState())
            countForButtonPress = countForButtonPress+1
            checkIfAllAccessGranted()
        }else{
            produceLocationAlert()
        }
    }
    
    @IBAction func contactAccess(_ sender: AnyObject) {
        let store = CNContactStore()
        if CNContactStore.authorizationStatus(for: .contacts) == .notDetermined{
            store.requestAccess(for: .contacts, completionHandler: {(authorized: Bool, error: NSError?) -> Void in
                if authorized{
                    // self.retrieveContacts(store)
                    self.countForButtonPress = self.countForButtonPress+1
                }
            } as! (Bool, Error?) -> Void)
        }else if CNContactStore.authorizationStatus(for: .contacts) == .authorized{
            // self.retrieveContacts(store)
        }else if CNContactStore.authorizationStatus(for: .contacts) == .denied {
            self.produceContactAlert()
        }else if CNContactStore.authorizationStatus(for: .contacts) == .restricted {
            self.produceContactAlert()
        }
        
        
        contactAccess.setImage(UIImage(named: "rightArrowCheckMark.png"), for: UIControlState())
        checkIfAllAccessGranted()
            contactAccess.setImage(UIImage(named: "rightArrowCheckMark.png"), for: UIControlState())
        checkIfAllAccessGranted()
    }
    
    func produceContactAlert(){
        let alrtUserforNoContactAccess: UIAlertController = UIAlertController (title:"Cannot Access Contacts", message:  "You must give Glanc permission to access contacts", preferredStyle: .alert)
        
        alrtUserforNoContactAccess.addAction(UIAlertAction(title: "Change Settings",
            style: .default,
            handler: { action in self.openSettings()}))
        
        alrtUserforNoContactAccess.addAction(UIAlertAction (title: "OK", style: .cancel, handler: nil))
        present(alrtUserforNoContactAccess, animated: true, completion: nil)
    }
    
    
    func produceLocationAlert(){
        let alrtUserforNoContactAccess: UIAlertController = UIAlertController (title:"Cannot Access Location", message:  "You must give Glanc permission to access location", preferredStyle: .alert)
        
        alrtUserforNoContactAccess.addAction(UIAlertAction(title: "Change Settings",
            style: .default,
            handler: { action in self.openSettings()}))
        
        alrtUserforNoContactAccess.addAction(UIAlertAction (title: "OK", style: .cancel, handler: nil))
        present(alrtUserforNoContactAccess, animated: true, completion: nil)
    }

    
    
    func openSettings(){
        let settingsURL = URL(string: UIApplicationOpenSettingsURLString)
        UIApplication.shared.openURL(settingsURL!)
    }
    
    
    func checkIfAllAccessGranted(){
        if( CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways && CNContactStore.authorizationStatus(for: .contacts) == .authorized || countForButtonPress > 3){
            let defaults = UserDefaults.standard
            defaults.set(true, forKey: "isLoggedIn")
            let modalStyle = UIModalTransitionStyle.crossDissolve
            let showUserTabBar = (self.storyboard?.instantiateViewController(withIdentifier: "userTabBar"))!
            showUserTabBar.modalTransitionStyle = modalStyle
            self.present(showUserTabBar, animated: false, completion: nil)
        }else{
            
        }
    }
}

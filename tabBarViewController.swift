//
//  userTabBarViewController.swift
//  
//
//  Created by Manmeet Swach on 2016-01-26.
//
//

import UIKit
import Floaty

class userTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        let color = UIColor(red: 46/255, green: 177/255, blue: 209/255, alpha: 1)
        let colorOfBackgroud = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1)
        UITabBar.appearance().tintColor = color
        UITabBar.appearance().barTintColor = colorOfBackgroud

        var freshLaunch = true
        if freshLaunch {
            freshLaunch = false
            self.tabBarController?.selectedIndex = 0
        }

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.selectedIndex = 1
        self.tabBar.clipsToBounds = true
        tabBar.topBorder()
            }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Functions to get the user into the application before doing anythinf further
    func AutologinUser (_ username: String, password: String, latitude: Double, longitude: Double){
        // This function produces true if the user loged into the application server and return usersID
        // Make call to server with
        // - username: Stored on device
        // - password: Stored on device
        // - latitude: Current location  ; check to see if user has granted access
        // - longitude: Current location ; check to see if user has granted access
        // - update time stamp on server side
        
        // Return
        // - userID and proced with requesting information on the user such as friends, 
        //   profile and other background requests
        // - user Not found: prompt user not found try again; show login screen
        //                   username saved in the text field but not the password field
        // - network error: Please try again due to connection error
        //                  username saved in the text field but not the password field
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

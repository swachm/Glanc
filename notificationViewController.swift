//
//  notificationSentViewController.swift
//  Glanc
//
//  Created by Manmeet Swach on 2016-02-13.
//  Copyright © 2016 Swach. All rights reserved.
//

import UIKit

class notificationSentViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var notificationSentTableView: UITableView!
    var arrayOfNotificationSentData = [notificationSentData]()
    
    var refreshControl: UIRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: #selector(notificationSentViewController.setUpNotificationData), for: UIControlEvents.valueChanged)
        self.notificationSentTableView.addSubview(refreshControl)
        self.setUpNotificationData()
        
        //if you dont want to do the right click
        // self.notificationSentTableView.delegate = self
        // self.notificationSentTableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //load notification data
    func setUpNotificationData ()
    {
        // Request data from server for the notification user has sent out
        // request is made on the second thread to avoinf main thread from blocking
        // - notificationID
        // - sentUserID
        // - sentUsername
        // - sentUserImage
        // - time
        // - requestStatus
        // - requestType
        
        //examples
        let data1 = notificationSentData(notificationID: 1, sentUserId: "hadjashdh", sentUsername: "Cody would like to know when you have left your current location.", sentUserImage: "cody.jpg", time: "1 hours ago", requestStatus: "Pending", requestType: "location")
        
        let data3 = notificationSentData(notificationID: 1, sentUserId: "hadjashdh", sentUsername: "Kanwal is requesting your location.", sentUserImage: "kanwal.jpg", time: "8 hours ago", requestStatus: "Pending", requestType: "GeoFence")
        
        arrayOfNotificationSentData.append(data1)
        arrayOfNotificationSentData.append(data3)
        self.refreshControl.endRefreshing()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfNotificationSentData.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notificationSentCell") as! notificationSentTableViewCell
       
        
        
        
        let oneDataPoint = arrayOfNotificationSentData[indexPath.row]
        cell.setCell(oneDataPoint.sentUsername, imageName: oneDataPoint.sentUserImage, Status: oneDataPoint.requestStatus, howLongAgo: oneDataPoint.time)

        //(indexPath.row)
                return cell
    }
    
    
    // find delegate function for row selection
    
    // when a row is selected what happenes?
    // trnasition to a new view - what type of animation is required
    // sent the request to server with: userID and notificationID
    // server returns:
    // - options 
    // - show user profile
    // - aview of the map 
    // - info requested from user
    // - status
    
    
}

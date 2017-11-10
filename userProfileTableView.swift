//
//  userProfileTableView.swift
//  Glanc
//
//  Created by Manmeet Swach on 2016-04-21.
//  Copyright © 2016 Swach. All rights reserved.
//

import UIKit
import AVFoundation

class userProfileTableView: UITableViewController {

    
    @IBOutlet weak var UpdateProfilePic: UIBarButtonItem!
    let captureSession = AVCaptureSession()
    var captureDevice : AVCaptureDevice?
    
    @IBOutlet weak var usernameField: UILabel!
    @IBOutlet weak var userProfilePic: UIImageView!
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.usernameField.text = defaults.string(forKey: "username")
           }
    @IBAction func activateProfileCamera(_ sender: AnyObject) {
        captureSession.sessionPreset = AVCaptureSessionPresetLow
        
        let devices = AVCaptureDevice.devices()
        
        for device in devices! {
            if ((device as AnyObject).hasMediaType (AVMediaTypeVideo)){
                if ((device as AnyObject).position == AVCaptureDevicePosition.back){
                    captureDevice = device as? AVCaptureDevice
                }
            }
        }
        
        if captureDevice != nil{
            beginCameraSession()
        }
    }
    
    func beginCameraSession(){
        
        do{
        try captureSession.addInput(AVCaptureDeviceInput (device: captureDevice))
        } catch let error as NSError{
            print(error)
        }
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        self.view.layer.addSublayer(previewLayer!)
        previewLayer?.frame = self.view.layer.frame
        captureSession.startRunning()
    }
    
}

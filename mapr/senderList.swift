//
//  settingsLauncher.swift
//  mapr
//
//  Created by Manmeet Swach on 2017-06-01.
//  Copyright © 2017 Manmeet Swach. All rights reserved.
//

import UIKit


class settingsLauncher: NSObject{
    
    
    let blackView = UIView()
    var sendButton = UIButton()
    var friendSelectedLabel = UILabel()
    
    func showBottomMenu(){
        if let window = UIApplication.shared.keyWindow{
            
            sendButton.backgroundColor = .green
            sendButton.addBorderToButton()
            sendButton.setTitle(">", for: .normal)
            sendButton.addTarget(self, action: #selector(sendNotifications), for: .touchUpInside)
            blackView.backgroundColor = UIColor.clear
            blackView.backgroundColor = UIColor(white: 0, alpha: 1)
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            window.addSubview(blackView)
            window.addSubview(sendButton)
            window.addSubview(friendSelectedLabel)

            
            self.friendSelectedLabel.backgroundColor = UIColor.clear
            self.sendButton.backgroundColor = UIColor.clear
            
            self.sendButton.frame = CGRect(x: 100, y: window.frame.height, width: window.frame.width, height: window.frame.height - 50)
            self.friendSelectedLabel.frame = CGRect(x: 100, y: window.frame.height, width: window.frame.width - 50, height: window.frame.height - 50)
            
            blackView.frame = window.frame
            blackView.alpha = 0
            
            UIView.animate(withDuration: 0.5, animations: {
                self.sendButton.frame = CGRect(x: 100, y: 50, width: window.frame.width, height: window.frame.height - 50)
                self.friendSelectedLabel.frame = CGRect(x: 100, y: 50, width: window.frame.width - 50, height: window.frame.height - 50)
            })
        }
    }
    
    func handleDismiss(){
        if let window = UIApplication.shared.keyWindow{
        UIView.animate(withDuration: 0.5, animations: {
            self.sendButton.frame = CGRect(x: 100, y: window.frame.height, width: window.frame.width, height: window.frame.height - 50)
            self.friendSelectedLabel.frame = CGRect(x: 100, y: window.frame.height, width: window.frame.width - 50, height: window.frame.height - 50)

        })
        }
    }
    
    func sendNotifications(){
        
    }

    
    override init(){
        super.init()
    }
    
    
}

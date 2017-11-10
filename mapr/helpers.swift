//
//  helpers.swift
//  Glanc
//
//  Created by Manmeet Swach on 2016-04-14.
//  Copyright © 2016 Swach. All rights reserved.
//

import UIKit
import Mapbox //for Blurring the MGLMapview

extension UITextField {
    func underlinedTextboxSelected (){
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = UIColor.white.cgColor
        border.frame = CGRect (x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
    func underlinedTextboxNotSelected (){
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = UIColor(red: 214/255, green: 224/255, blue: 231/255, alpha: 1).cgColor
        border.frame = CGRect (x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
    
    func passwordLine (){
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1).cgColor
        border.frame = CGRect (x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
    func addShadow (){
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
    }
}

extension UIButton{
    
    func addBorderToButton(){
        self.layer.backgroundColor = UIColor (red: 46/255, green: 177/255, blue: 209/255, alpha: 1.0).cgColor
        self.layer.borderColor = UIColor (red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).cgColor
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 2
    }
}

extension MGLMapView{
    
    func blurTheMapView(){
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
    }
    
    func unblurTheMapView(){
        
    }
}

extension UITabBar{
    func topBorder(){
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = UIColor(red: 46/255, green: 177/255, blue: 209/255, alpha: 1.0).cgColor
        border.frame = CGRect(x: 0 - width, y: 0, width: self.frame.size.width + (2 * width), height: self.frame.size.height + width)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
}

extension UIImageView{
    func friendListImage(){
        let border = CALayer()
        let width = CGFloat(5.0)
        border.borderColor = UIColor(red: 46/255, green: 177/255, blue: 209/255, alpha: 1.0).cgColor
        border.borderWidth = width
        self.layer.cornerRadius = 20
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}

//
//  logedInMainPageViewController.swift
//  Glanc
//
//  Created by Manmeet Swach on 2016-01-21.
//  Copyright © 2016 Swach. All rights reserved.
//

import UIKit
import CoreLocation
import Mapbox
import MapboxGeocoder
import Floaty
import Alamofire

//import EZLoadingActivity   //Activity Bar

class logedInMainPageViewController: UIViewController, MGLMapViewDelegate, UITextFieldDelegate{

    //MARK: Location Data

    var locManager = CLLocationManager()
    var userLatitude :Double = 0
    var userLongitude: Double = 0
    var mapView: MGLMapView!
    var optionsButton = Floaty()
    
    @IBOutlet weak var myLocationButton: UIButton!
    @IBOutlet weak var searchMap: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // myLocationButton.layer.cornerRadius = 20
        
        searchMap.delegate = self
        //mapView.delegate = self    //-> Uncomment to change the icon to custom, error received that the it is nil
        // searchMap.addTarget(self, action: "textfieldDidChange", forControlEvents: UIControlEvents.EditingChanged)
        
        
        locManager.desiredAccuracy = kCLLocationAccuracyBest
        locManager.requestAlwaysAuthorization()
        locManager.startUpdatingLocation()
        
        if( CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways){
            userLatitude = (locManager.location?.coordinate.latitude)!
            userLongitude = (locManager.location?.coordinate.longitude)!
        }
        // Do any additional setup after loading the view.
        
        print(userLongitude)
        print(userLatitude)
        
        locManager.stopUpdatingLocation()
        
        mapView = MGLMapView(frame: view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.setCenter(CLLocationCoordinate2D (latitude: userLatitude, longitude: userLongitude), zoomLevel: 16, animated: false)
        
        // let userMarker = MGLPointAnnotation()
        //mapView.addAnnotation(userMarker)
        //        let mapView = MGLMapView(frame: view.bounds)
        //        mapView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        //
        //        mapView.setCenterCoordinate(CLLocationCoordinate2D(latitude: userLatitude,
        //            longitude: userLongitude),
        //            zoomLevel: 16, animated: false)
        
        myLocationButton.layer.cornerRadius = 5
        myLocationButton.layer.borderColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0).cgColor
        myLocationButton.layer.borderWidth = 2

                optionsButton.addItem("Request Location", icon: UIImage(named: "recieveGeofence")!, handler: { item in
                    self.optionsButton.close()
                     let userFriendView = self.storyboard?.instantiateViewController(withIdentifier: "friendsFromContact")
                      self.present(userFriendView!, animated: true, completion: nil) //controller.popViewControllerAnimated(true)
                    // PopViewController fromt the bottom of the screen with all the users friends
                    // Pass to the view controller
                    // - Type: RequestGeofence
        
                })
        
                optionsButton.addItem("Send Location", icon: UIImage(named: "sendGeofence")!, handler: { item in
                    self.optionsButton.close()
                    let userFriendView = self.storyboard?.instantiateViewController(withIdentifier: "friendsFromContact")
                    self.present(userFriendView!, animated: true, completion: nil) //controller.popViewControllerAnimated(true)
                    // PopViewController fromt the bottom of the screen with all the users friends
                    // Pass to the view controller
                    // - Type: RequestGeofence
        
                })
        
        searchMap.attributedPlaceholder = NSAttributedString (string: "Location of Geofence?", attributes: [NSForegroundColorAttributeName: UIColor.white])
        searchMap.addShadow()
        view.addSubview(mapView)
        view.addSubview(myLocationButton)
        view.addSubview(optionsButton)
        view.addSubview(searchMap)
        
        
        let marker = MGLPointAnnotation()
        marker.coordinate = CLLocationCoordinate2DMake(userLatitude,userLongitude)
        mapView.addAnnotation(marker)
        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Actions for the map
    @IBAction func myLocationButtonAction(_ sender: AnyObject) {
        locManager.startUpdatingLocation()
        print(userLongitude)
        print(userLatitude)
        locManager.stopUpdatingLocation()
        userLatitude = (locManager.location?.coordinate.latitude)!
        userLongitude = (locManager.location?.coordinate.longitude)!
        mapView.setCenter(CLLocationCoordinate2D(latitude: userLatitude, longitude: userLongitude), zoomLevel: 16, animated: true)
        let marker = MGLPointAnnotation()
        marker.coordinate = CLLocationCoordinate2DMake(userLatitude,userLongitude)
        mapView.addAnnotation(marker)
        //Update Location
    }
    
    //Use the default marker
    func mapView(_ mapView: MGLMapView, imageFor annotation: MGLAnnotation) -> MGLAnnotationImage? {
        var annotationImage = mapView.dequeueReusableAnnotationImage(withIdentifier: "marker1")
        
        if annotationImage == nil {
            var image = UIImage(named: "marker")
            image = image!.withAlignmentRectInsets(UIEdgeInsetsMake(0, 0, image!.size.height/2, 0))
            annotationImage = MGLAnnotationImage(image: image!, reuseIdentifier: "marker1")
        }
        return annotationImage
    }
    
    // Show anotation when the marker is tapped
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true
    }
    
    @IBAction func slingAllFriends(_ sender: AnyObject) {
        //PFUser.logOutInBackground()
        self.tabBarController?.selectedIndex = 0
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       // performSearch()
        performLatLongSearch()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        mapView.blurTheMapView()
    }
    
    func performLatLongSearch(){
        var geocoder = Geocoder.shared
        let options = ForwardGeocodeOptions(query: searchMap.text!)
        
        let task = geocoder.geocode(options) { (placemarks, attribution, error) in
            guard let placemark = placemarks?.first else {
                return
            }
            
            print(placemark.name)
            // 200 Queen St
            print(placemark.qualifiedName)
            // 200 Queen St, Saint John, New Brunswick E2L 2X1, Canada
            
            let coordinate = placemark.location.coordinate
            self.zoomMapToThisLocation(coordinate)
        }
    }
    
    func zoomMapToThisLocation(_ results: CLLocationCoordinate2D){
        self.view.endEditing(true)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.setCenter(CLLocationCoordinate2D (latitude: results.latitude, longitude: results.longitude), zoomLevel: 13, animated: true)
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

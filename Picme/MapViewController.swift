//
//  MapViewController.swift
//  Picme
//
//  Created by John Nguyen on 4/5/15.
//  Copyright (c) 2015 John Nguyen. All rights reserved.
//

import UIKit

class MapViewController: UIViewController ,GMSMapViewDelegate , CLLocationManagerDelegate {
 var events = []
 var mapView = GMSMapView()
let locationManager =  CLLocationManager()
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        var camera = GMSCameraPosition.cameraWithLatitude(-33.86,
            longitude: 151.20, zoom: 6)
        mapView = GMSMapView.mapWithFrame(CGRectZero, camera: camera)
        mapView.myLocationEnabled = true
        mapView.settings.myLocationButton = true
        
        self.view = mapView
        let query : PFQuery = PFQuery(className: "Event")
        query.findObjectsInBackgroundWithBlock {  (objects: [AnyObject]!, error: NSError!) -> Void in
            if error != nil {
                // There was an error
            } else {
                self.events = objects
                self.setMarkerData()
            }
        }
        // Do any additional setup after loading the view.
    }
    
    
    func setMarkerData(){
        for event in events  {
            mapView.delegate = self
            let latitude:Double = event["Latitude"] as Double
            let longitude:Double = event["Longitude"] as Double
            let position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            var marker :GMSMarker = GMSMarker(position: position)
            marker.title = event["Title"] as String
            let imageData : PFFile = event["Image"] as PFFile
            imageData.getDataInBackgroundWithBlock({   (imageData: NSData!, error: NSError!) -> Void in
                if !(error != nil) {
                     marker.userData = UIImage(data:imageData)
                }
                
            })
            switch (event["Type"]) as String{
            case "Sports":
                marker.icon = UIImage(named: "sportsMarker")
            case "Gaming":
                marker.icon = UIImage(named: "gamesMarker")
            default:
                marker.icon = UIImage(named: "otherMarker")
            }
            marker.map = mapView
        }

    }
    
    func compressImage(original:UIImage, scale:CGFloat)->UIImage{
        let originalSize = original.size
        let newSize = CGSizeMake(originalSize.width * scale, originalSize.height * scale)
        UIGraphicsBeginImageContext(newSize)
        original.drawInRect(CGRectMake(0, 0, newSize.width, newSize.height))
        let compressedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return compressedImage
        
    }
    
    func mapView(mapView: GMSMapView!, didTapInfoWindowOfMarker marker: GMSMarker!) {
        //Take to event window 
    }
    
    func mapView(mapView: GMSMapView!, markerInfoWindow marker: GMSMarker!) -> UIView! {
        print("something happened")
        var infoWindow :CustomInfoWindow = NSBundle.mainBundle().loadNibNamed("eventInfo", owner: self, options: nil)[0] as CustomInfoWindow
        
        infoWindow.eventTitle.text = marker.title
        infoWindow.eventAttendees.text = "0"
        infoWindow.eventImage.image = marker.userData as? UIImage
        return infoWindow
    }
    
    func mapView(mapView: GMSMapView!, didTapMarker marker: GMSMarker!) -> Bool {
        print("did tap called")
        mapView.selectedMarker = marker
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func locationManager(manager:CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus){
        if status == .AuthorizedWhenInUse{
            
            locationManager.startUpdatingLocation()
            
            mapView.myLocationEnabled = true
            mapView.settings.myLocationButton = true
        }
    }
    
    func locationManager(manager:CLLocationManager!, didUpdateLocations locations:[AnyObject]!){
        if let location = locations.first as? CLLocation{
            
            mapView.camera = GMSCameraPosition(target:location.coordinate, zoom:15,bearing:0, viewingAngle:0)
            locationManager.stopUpdatingLocation()
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

//
//  Event_Cell.swift
//  iCompanion
//
//  Created by gEeYaR's MacBook Pro on 22/04/2017.
//  Copyright © 2017 UCD. All rights reserved.
//

import UIKit
import MessageUI
import MapKit
import CoreLocation

class Event_Cell: UITableViewCell, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var event_title: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!
    
    let eventTVC = EventsTVC()
    
    let geoCoder = CLGeocoder()
    
    var latitude: CLLocationDegrees? = nil
    var longitude: CLLocationDegrees? = nil
    
    var manager = CLLocationManager()
    let latZoom:CLLocationDegrees = 0.01
    let longZoom:CLLocationDegrees = 0.01
    
    
    @IBOutlet weak var event_description: UILabel!
    var event_data = Event() {
        didSet {
            refreshCell()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    var call : String = " "
    var mail : String = " "
    
    func refreshCell()
    {
        event_title.text = event_data.title
        event_description.text = event_data.event_description
        call = event_data.phone_no!
        mail = event_data.email!
        
       fetchAddress()
    }
    
    func fetchAddress(){
        
        let address = "\(event_data.house_no!)"+","+"\(event_data.street!)"+","+"\(event_data.city!)"
        
       // let address = "\(event_data.city!)"
        geoCoder.geocodeAddressString(address, completionHandler: {(placemarks,error) -> Void in
            if error != nil {
                print("error")
            }
            else {
                
                if let placemark = placemarks?[0] {
                    
                    self.latitude = placemark.location!.coordinate.latitude
                    self.longitude = placemark.location!.coordinate.longitude
                    self.setupMap()
                    self.addAnnotation()
                }
            }
        })
        
//        
//        setupMap()
//        addAnnotation()
    }
    
    @IBAction func callOrganiser(_ sender: UIButton) {
        let url: NSURL = URL(string: "TEL://"+"\(call)")! as NSURL
        UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
    }
    
    @IBAction func mailOrganizer(_ sender: UIButton) {
        
        let mailCompose = MFMailComposeViewController()
    
        
        mailCompose.mailComposeDelegate = self
        
        mailCompose.setToRecipients(["geeyarbabu@gmail.com"])
        
        // +  "\(String(describing: event_data.title))"
        mailCompose.setSubject("Reg: Inquiry regarding")
        
        //+"\n"+"I would like to inquire about event"+"\(String(describing: event_data.title))"+"Could you please provide me more information about it"
        mailCompose.setMessageBody("Hi,", isHTML: false)
        
        if MFMailComposeViewController.canSendMail(){
           // self.present(mailCompose, animated: true, completion: nil)
          //  UIApplication.shared.keyWindow?.rootViewController?.present(mailCompose, animated: true, completion: nil)
      
            self.window?.rootViewController?.present(mailCompose, animated: true, completion: nil)
            
            
        }
        else{
            print("Error...!")
        }
        
    
        
        
        
       // EventsTVC.sendMail()
    }
    
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func getDirections(_ sender: UIButton) {
        
        
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(self.latitude!, self.longitude!)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "university college dublin"
        mapItem.openInMaps(launchOptions: options)

    }
    
    
    func setupMap()
    {
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(latZoom, longZoom)
        
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(self.latitude!, self.longitude!)
        
        
        let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        mapView.setRegion(region, animated: true)
        mapView.mapType = .standard
        
        
    }
    
    func addAnnotation(){
        
        
      
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude!, longitude!)
        
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "Home"
        annotation.subtitle = "Come Home"
        
        mapView.addAnnotation(annotation)
    }


}

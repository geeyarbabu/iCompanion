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
import Firebase

// Class that configures the EventsTVC datacell
class Event_Cell: UITableViewCell, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var event_title: UILabel!
    @IBOutlet weak var event_date: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var favouritesButton: UIButton!
    @IBOutlet weak var interestImage: UIImageView!
    @IBOutlet weak var interestButton: UIButton!
    @IBOutlet weak var goingImage: UIImageView!
    @IBOutlet weak var goingButton: UIButton!
    @IBOutlet weak var getDirectionButton: UIButton!
    @IBOutlet weak var event_description: UILabel!
    
    var model = ModelClass()
    
    var event_data = Event() {
        didSet {
            populateCell()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    // MARK: - Method to populate the content of the Cell
    func populateCell()
    {
        // to detect the events that have been finised and putting a description ot the user on its finish
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let date = formatter.date(from: event_data.date_of_event!)
        let currentDate = Date()
        
        if( date! > currentDate){
            event_title.text = event_data.title
            event_description.text = event_data.event_description
            event_date.text = event_data.date_of_event!
        }
            
        else {
            event_title.text = event_data.title! + "(Missed)"
            
            event_description.text = event_data.event_description! + " \n[The event date has lapsed]"
            
            event_date.text = event_data.date_of_event!
            
            favouritesButton.isEnabled = false
            interestButton.isEnabled = false
            goingButton.isEnabled = false
        }
        
        setupButtons()
        fetchAddress()
        
        
    }
    
    // Updating the button's images based on the user actions perfomed
    func setupButtons()
    {
        model.fetchFavourites()
        for favItem in model.favo
        {
            if favItem.event_title == event_data.title
            {
                favouritesButton.setImage(#imageLiteral(resourceName: "favourited"), for: UIControlState.normal)
                favouritesButton.isUserInteractionEnabled = false
                
            }
        }
        
        model.fetchInterested()
        for interstItem in model.interest
        {
            if interstItem.event_title == event_data.title
            {
                interestImage.image = #imageLiteral(resourceName: "InterestedYes")
                interestButton.isUserInteractionEnabled = false
                interestButton.isEnabled = false
                
                
            }
        }
        
        model.fetchGoing()
        for goingItem in model.going
        {
            if goingItem.event_title == event_data.title
            {
                goingImage.image = #imageLiteral(resourceName: "goingYes")
                goingButton.isUserInteractionEnabled = false
            }
        }
    }
    
    
    //MARK: - Populating the map view
    func fetchAddress(){
        
        let address = "\(event_data.house_no!)"+","+"\(event_data.street!)"+","+"\(event_data.city!)"
        
        model.geoCoder.geocodeAddressString(address, completionHandler: {(placemarks,error) -> Void in
            if error != nil {
                print("error")
            }
            else {
                if let placemark = placemarks?[0] {
                    self.model.latitude = placemark.location!.coordinate.latitude
                    self.model.longitude = placemark.location!.coordinate.longitude
                    self.setupMap()
                    self.addAnnotation()
                }
            }
        })
    }
    
    // Method to configure the map with the required latitude, longitude and zoom level
    func setupMap()
    {
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(model.latZoom, model.longZoom)
        
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(model.latitude!, model.longitude!)
        
        
        let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        mapView.setRegion(region, animated: true)
        mapView.mapType = .standard
    }
    
    // Method to add the annotation point in the map view
    func addAnnotation(){
        
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(model.latitude!, model.longitude!)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "Event Location"
        annotation.subtitle = "\(String(describing: event_data.title!))"
        
        mapView.addAnnotation(annotation)
    }
    
    //MARK: - User Actions
    
    // Method to handle the favourites
    @IBAction func favourites_pressed(_ sender: UIButton) {
        
        model.saveFavourite(eventTitle: event_data.title!, eventDate: event_data.date_of_event!, eventDescription: event_data.event_description!)
        
        sender.setImage(#imageLiteral(resourceName: "favourited"), for: UIControlState.normal)
        sender.isUserInteractionEnabled = false
    }
    
    
    
    // Method to handle the call feature
    @IBAction func callOrganiser(_ sender: UIButton) {
        let url: NSURL = URL(string: "TEL://"+"\(event_data.phone_no!)")! as NSURL
        UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
    }
    
    // Method to direct the user from the user's current location to the event location
    @IBAction func getDirections(_ sender: UIButton) {
        
        if model.latitude == nil || model.longitude == nil {
            self.getDirectionButton.isEnabled = false
        }
        else {
            self.model.getDirection(eventTitle: event_data.title!)
        }
        
    }
    
    //Method to handle the user's interested prefereence
    @IBAction func interested_pressed(_ sender: UIButton) {
        
        model.saveInterested(eventTitle: event_data.title!, eventDate: event_data.date_of_event!)
        
        interestImage.image = #imageLiteral(resourceName: "InterestedYes")
        interestButton.isUserInteractionEnabled = false
        
        let title = "INTERESTED: " + event_data.title!
        
        model.addToCalender(eventDate: event_data.date_of_event!, eventTitle: title  )
        
    }
    
    //Method to handle user's going preference
    @IBAction func going_pressed(_ sender: UIButton) {
        
        model.saveGoing(eventTitle: event_data.title!, eventDate: event_data.date_of_event!)
        
        goingImage.image = #imageLiteral(resourceName: "goingYes")
        goingButton.isUserInteractionEnabled = false
        
        let title = "GOING: " + event_data.title!
        
        model.addToCalender(eventDate: event_data.date_of_event!, eventTitle: title  )
    }
    
    
    
    
}

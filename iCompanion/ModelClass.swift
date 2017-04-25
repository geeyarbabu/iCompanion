//
//  ModelClass.swift
//  iCompanion
//
//  Created by gEeYaR's MacBook Pro on 24/04/2017.
//  Copyright © 2017 UCD. All rights reserved.
//

import Foundation
import MessageUI
import MapKit
import CoreLocation
import Firebase
import EventKit


class ModelClass : NSObject {
    
    var event : [Event] = []
    var favo : [Favourites] = []
    var interest : [Interested] = []
    var going : [Going] = []

    var dept = ["Computer Science" , "Engineering" , "Science", "Electronics"]
    let picker = UIPickerView()
    
    
    let geoCoder = CLGeocoder()
    
    var latitude: CLLocationDegrees? = nil
    var longitude: CLLocationDegrees? = nil
    
    var manager = CLLocationManager()
    let latZoom:CLLocationDegrees = 0.01
    let longZoom:CLLocationDegrees = 0.01
    


    static var happyCounter = 0
    static var sadCounter = 0
    static var resetCounter = 0
    var moodFlag = String()
    
    var savedEventId = String()
    
    
    func eventFetch()
    {
        let container = UIApplication.shared.delegate as! AppDelegate
        let context = container.persistentContainer.viewContext
        do {
            event = try context.fetch(Event.fetchRequest())
        }
        catch{
            print("error")
        }
    }
    
    func saveEvent( event_title: String,event_description: String, house_number: String, street_name: String, event_city: String, date_of_event: String, phone_number: String, email: String ,department: String  )
    {
        let container = UIApplication.shared.delegate as! AppDelegate
        let context = container.persistentContainer.viewContext
        
        let event = Event(context: context)
        
        event.title = event_title
        event.event_description = event_description
        event.house_no = house_number
        event.street = street_name
        event.city = event_city
        event.date_of_event = date_of_event
        event.phone_no = phone_number
        event.email = email
        event.department = department
        
        container.saveContext()
    }

    
    func fetchFavourites()
    {
        let container = UIApplication.shared.delegate as! AppDelegate
        
        let context = container.persistentContainer.viewContext
        
        do {
            
            favo = try context.fetch(Favourites.fetchRequest())
        }
        catch{
            print("error")
        }
    }

    func fetchInterested()
    {
        let container = UIApplication.shared.delegate as! AppDelegate
        
        let context = container.persistentContainer.viewContext
        
        do {
            
            interest = try context.fetch(Interested.fetchRequest()) as! [Interested]
        }
        catch{
            print("error")
        }
    }

    func fetchGoing()
    {
        let container = UIApplication.shared.delegate as! AppDelegate
        
        let context = container.persistentContainer.viewContext
        
        do {
            
            going = try context.fetch(Going.fetchRequest()) as! [Going]
        }
        catch{
            print("error")
        }
    }

    
    func getDirection(eventTitle: String)
    {
        
      
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(self.latitude!, self.longitude!)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "\(String(describing: eventTitle))"
        mapItem.openInMaps(launchOptions: options)
        
    }
    
    
    
    func saveFavourite(eventTitle: String, eventDate: String, eventDescription: String)
    {
    let container = UIApplication.shared.delegate as! AppDelegate
    let context = container.persistentContainer.viewContext
    
    let favourite = Favourites(context: context)
    
    favourite.event_title = eventTitle
    favourite.event_date = eventDate
    favourite.event_description = eventDescription
    let user = FIRAuth.auth()?.currentUser
    if let userName = user{
        favourite.user_name = userName.email!
    }
    
    
    container.saveContext()
    }
    
    
    func saveInterested(eventTitle: String, eventDate: String){
        let container = UIApplication.shared.delegate as! AppDelegate
        let context = container.persistentContainer.viewContext
        
        let interest = Interested(context: context)
        
        interest.event_title = eventTitle
        interest.event_date = eventDate
        let user = FIRAuth.auth()?.currentUser
        if let userName = user{
            interest.user_name = userName.email!
        }
        
        container.saveContext()
    }
    
    func saveGoing(eventTitle: String, eventDate: String){
        let container = UIApplication.shared.delegate as! AppDelegate
        let context = container.persistentContainer.viewContext
        
        let going = Going(context: context)
        
        going.event_title = eventTitle
        going.event_date = eventDate
        let user = FIRAuth.auth()?.currentUser
        if let userName = user{
            going.user_name = userName.email!
        }
        
        container.saveContext()

    }
    
    
    func addToCalender(eventDate: String, eventTitle: String) {
        
        //Adds event in calender
        let eventStore = EKEventStore()
        
        let formatter2 = DateFormatter()
        formatter2.dateFormat = "dd-MM-yyyy"
        let date2 = formatter2.date(from: eventDate)
        
        
        
        let startDate = date2
        let endDate = startDate?.addingTimeInterval(86400) // One hour
        
        if (EKEventStore.authorizationStatus(for: .event) != EKAuthorizationStatus.authorized) {
            eventStore.requestAccess(to: .event, completion: {
                granted, error in
                self.createEvent(eventStore, title: eventTitle, startDate: startDate!, endDate: endDate!)
            })
        } else {
            createEvent(eventStore, title: eventTitle, startDate: startDate!, endDate: endDate!)
        }

    }
    
    
    
    
    
    
    
    
    
    // Creates an event in the EKEventStore. The method assumes the eventStore is created and
    // accessible
    func createEvent(_ eventStore: EKEventStore, title: String, startDate: Date, endDate: Date) {
        let event = EKEvent(eventStore: eventStore)
        
        event.title = title
        event.startDate = startDate
        event.endDate = endDate
        event.calendar = eventStore.defaultCalendarForNewEvents
        do {
            try eventStore.save(event, span: .thisEvent)
            savedEventId = event.eventIdentifier
        } catch {
            print("Error...")
        }
    }

    
}



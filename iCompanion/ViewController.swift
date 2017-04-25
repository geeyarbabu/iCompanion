//
//  ViewController.swift
//  iCompanion
//
//  Created by gEeYaR's MacBook Pro on 15/04/2017.
//  Copyright © 2017 UCD. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import UserNotifications
import MessageUI

class ViewController: UIViewController, UNUserNotificationCenterDelegate, GIDSignInUIDelegate {
    
    
    //var model = ModelClass()
    
    
    var moodTimer: Timer!
    
     static var happyCounter = 0
     static var sadCounter = 0
     static var resetCounter = 0
    
    
        @IBOutlet weak var adminBtnPressed: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moodTimer = Timer.scheduledTimer(timeInterval: 28800, target: self, selector: #selector(displayAlert), userInfo: nil, repeats: true)
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()
        
    }
    
    
    func displayAlert()
    {
        
        ViewController.resetCounter = ViewController.resetCounter + 1
        print(ViewController.resetCounter)
        
        if ViewController.resetCounter == 9    // To indicate that the entries have been fetched for 3 days
        {
            moodTimer.invalidate()
            moodTimer = nil
            ViewController.resetCounter = 0
            
            
            if ViewController.sadCounter > ViewController.happyCounter
            {
                ViewController.sadCounter = 0
                ViewController.happyCounter = 0
                print ("You are sad")
                
                let alert = UIAlertController(title: "Oops..!", message: "you seem sad for a while. Please select an action to take a break and refresh yourself.", preferredStyle: UIAlertControllerStyle.alert)
             
                alert.addAction(UIAlertAction(title: "BOOK A MOVIE", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in UIApplication.shared.open(NSURL(string:"https://www.cineworld.ie")! as URL, options: [:], completionHandler: nil) }))
                
                alert.addAction(UIAlertAction(title: "PUBLIC EVENTS", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in UIApplication.shared.open(NSURL(string:"https://www.eventbrite.ie")! as URL, options: [:], completionHandler: nil) }))
                        
                self.present(alert, animated: true, completion: nil)
                
                
            }
            else
            {
                ViewController.sadCounter = 0
                ViewController.happyCounter = 0
                print("you are happy")
                
                let alert2 = UIAlertController(title: "Happy Days", message: "We are glad that you're happy over the days. We hope your happeniess continues long", preferredStyle: UIAlertControllerStyle.alert)
                
                alert2.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                
                self.present(alert2, animated: true, completion: nil)
                
                
            }
            
            moodTimer = Timer.scheduledTimer(timeInterval: 28800, target: self, selector: #selector(displayAlert), userInfo: nil, repeats: true)

        }
        
        let happy = UNNotificationAction(identifier: "happy", title: "Happy", options: .foreground)
        
        let sad = UNNotificationAction(identifier: "sad", title: "Sad", options: .foreground)
        
        let category = UNNotificationCategory(identifier: "category", actions: [happy,sad], intentIdentifiers: [], options: [])
        
        UNUserNotificationCenter.current().setNotificationCategories([category])
        
        let content = UNMutableNotificationContent()
        content.title = "Hi buddy"
        content.subtitle = "How's your day today"
        content.body = "please let us know your mood to help you"
        content.categoryIdentifier = "category"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: "timerdown", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
        
    }
    
        override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func adminBtnPressed(_ sender: UIButton) {
        
    }
   

}


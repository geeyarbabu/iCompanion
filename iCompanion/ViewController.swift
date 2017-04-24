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
    
    
    var getMood: Timer!
    
    static var happyCounter = 0
    static var sadCounter = 0
    static var counter = 0
    
    
    @IBOutlet weak var signInButton: GIDSignInButton!
    
     @IBOutlet weak var adminBtnPressed: UIButton!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let happy = UNNotificationAction(identifier: "happy", title: "happy", options: .foreground)
//        
//        let sad = UNNotificationAction(identifier: "sad", title: "sad", options: .foreground)
//        
//        let category = UNNotificationCategory(identifier: "cat", actions: [happy,sad], intentIdentifiers: [], options: [])
//        
//        UNUserNotificationCenter.current().setNotificationCategories([category])
//        
//        let content = UNMutableNotificationContent()
//        content.title = "Hi buddy"
//        content.subtitle = "I hope, you are well"
//        content.body = "How do you feel today?"
//        content.categoryIdentifier = "cat"
//        //content.badge = 1
//        
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
//        let request = UNNotificationRequest(identifier: "timerdome", content: content, trigger: trigger)
//        
//        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
        
        
        
        
        
        
        getMood = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(displayAlert), userInfo: nil, repeats: true)
        
        
        
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()
        
    }
    
    
    func displayAlert()
    {
        ViewController.counter = ViewController.counter + 1
        
        if ViewController.counter >= 5
        {
            getMood.invalidate()
            getMood = nil
            
            if ViewController.sadCounter > ViewController.happyCounter
            {
                ViewController.sadCounter = 0
                ViewController.happyCounter = 0
                print ("you are sad")
                
                let alert = UIAlertController(title: "HI", message: "you are sad for a while", preferredStyle: UIAlertControllerStyle.alert)
                
                
                alert.addAction(UIAlertAction(title: "EVENTS", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
                    
                    //self.tabBarController?.selectedIndex = 1
//                    UIApplication.shared.open(NSURL(string:"https://www.cineworld.ie")! as URL, options: [:], completionHandler: nil)
                    
                    
                    let storyBoard : UIStoryboard = UIStoryboard(name: "tabbar", bundle:nil)
                    
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "event_tvc") as! EventsTVC
                    self.present(nextViewController, animated:true, completion:nil)
                }))
                
                alert.addAction(UIAlertAction(title: "BOOK A MOVIE", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in UIApplication.shared.open(NSURL(string:"https://www.cineworld.ie")! as URL, options: [:], completionHandler: nil) }))
                
                alert.addAction(UIAlertAction(title: "PUBLIC EVENTS", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in UIApplication.shared.open(NSURL(string:"https://www.cineworld.ie")! as URL, options: [:], completionHandler: nil) }))
                        
                self.present(alert, animated: true, completion: nil)
                
                
            }
            else
            {
                ViewController.sadCounter = 0
                ViewController.happyCounter = 0
                print("you are happy")
            }
        }
        
        let happy = UNNotificationAction(identifier: "happy", title: "happy", options: .foreground)
        
        let sad = UNNotificationAction(identifier: "sad", title: "sad", options: .foreground)
        
        let category = UNNotificationCategory(identifier: "cat", actions: [happy,sad], intentIdentifiers: [], options: [])
        
        UNUserNotificationCenter.current().setNotificationCategories([category])
        
        let content = UNMutableNotificationContent()
        content.title = "Hi buddy"
        content.subtitle = "I hope, you are well"
        content.body = "How do you feel today?"
        content.categoryIdentifier = "cat"
        //content.badge = 1
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: "timerdome", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
        
    }
    
        override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func adminBtnPressed(_ sender: UIButton) {
        
    }
   

}


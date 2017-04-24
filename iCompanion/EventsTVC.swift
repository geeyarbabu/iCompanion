//
//  EventsTVC.swift
//  iCompanion
//
//  Created by gEeYaR's MacBook Pro on 21/04/2017.
//  Copyright © 2017 UCD. All rights reserved.
//

import UIKit
import MessageUI
import UserNotifications

class EventsTVC: UITableViewController, UNUserNotificationCenterDelegate, MFMailComposeViewControllerDelegate {

    var getMood: Timer!
    var event : [Event] = []
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()

    

//        getMood = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(displayAlert), userInfo: nil, repeats: true)
//    
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    
    
//    func displayAlert()
//    {
//        
//        let alert = UIAlertController(title: "HI", message: "How is your mood today", preferredStyle: UIAlertControllerStyle.alert)
//        
//        
//        alert.addAction(UIAlertAction(title: "HAPPY", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in EventsTVC.happyCounter += 1 }))
//        
//        alert.addAction(UIAlertAction(title: "SAD", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in EventsTVC.sadCounter += 1 }))
//        
//        self.present(alert, animated: true, completion: nil)
//        
//        if EventsTVC.sadCounter >= 2
//        {
//            
//            alertTwo()
//            
//        }
    
        
//        let sadAlert = UIAlertController(title: "HI Buddy", message: "you are worried for the past few minutes", preferredStyle: UIAlertControllerStyle.alert)
//        //let cancel = UIAlertAction(title: "cancel", style: UIAlertActionStyle.default, handler: nil)
//        
//        sadAlert.addAction(UIAlertAction(title: "cancel", style: UIAlertActionStyle.default, handler: nil))
//        
//        self.present(sadAlert, animated: true, completion: nil)
//        
        
        
    
    
    
//    func alertTwo()
//    {
//        getMood.invalidate()
//        getMood = nil
//        
//        let sadAlert = UIAlertController(title: "HI Buddy", message: "you are worried for the past few minutes", preferredStyle: UIAlertControllerStyle.alert)
//        //let cancel = UIAlertAction(title: "cancel", style: UIAlertActionStyle.default, handler: nil)
//        
//        sadAlert.addAction(UIAlertAction(title: "cancel", style: UIAlertActionStyle.default, handler: nil))
//        
//        self.present(sadAlert, animated: true, completion: nil)
//        
//        print("bgjhgb")
//    }

    
    override func viewWillAppear(_ animated: Bool) {
        getData()
        
        tableView.reloadData()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return event.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "event_cell", for: indexPath) as! Event_Cell
 
      //  let cell = UITableViewCell()
        
      //  let event_fetched = event[indexPath.row]
        
        cell.event_data = event[indexPath.row]
        
        // Configure the cell...

        return cell
    }
    

    func getData()
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
    
 
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let shareAction = UITableViewRowAction(style: .normal, title:"Mail the Organiser") { (action: UITableViewRowAction!, indexPath: IndexPath!) -> Void in
            
            
            let mailCompose = MFMailComposeViewController()
            
            
            mailCompose.mailComposeDelegate = self
            
            
            mailCompose.setToRecipients([self.event[indexPath.row].email!])
            
            // +  "\(String(describing: event_data.title))"
            mailCompose.setSubject("Reg: Inquiry regarding")
            
            
            mailCompose.setMessageBody("Hi,"+"\n"+"I would like to inquire about event "+"\(String(describing: self.event[indexPath.row].title!))"+". Could you please provide me more information about it?", isHTML: false)
            
            if MFMailComposeViewController.canSendMail(){
                
                self.present(mailCompose, animated: true, completion: nil)
                
            }
            else{
                print("Error...!")
            }

            
            
            
            
        }
        
        return [shareAction]
    }
    
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
}


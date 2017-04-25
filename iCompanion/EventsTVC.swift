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


// Class that displays the Events of the university to the user
class EventsTVC: UITableViewController, UNUserNotificationCenterDelegate, MFMailComposeViewControllerDelegate {
    
    var moodTimer: Timer!
    
    var model = ModelClass()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // Method to fetch the table content before the table appears
    override func viewWillAppear(_ animated: Bool) {
        model.eventFetch()
        tableView.reloadData()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.event.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "event_cell", for: indexPath) as! Event_Cell
        
        cell.event_data = model.event[indexPath.row]
        
        return cell
        
    }
    
    // MARK: - Mailing Feature
    
    // As we have to present the mail view in the parent view, we have left the method in the controller, becuase it couldnt be displayed in the event_cell
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let shareAction = UITableViewRowAction(style: .normal, title:"Mail the Organiser") { (action: UITableViewRowAction!, indexPath: IndexPath!) -> Void in
            
            // obtain a configured MFMailComposeViewController instance
            let mailCompose = MFMailComposeViewController()
            
            
            mailCompose.mailComposeDelegate = self
            
            // setToRecipients() accepts an e-mail address strings
            mailCompose.setToRecipients([self.model.event[indexPath.row].email!])
            
            // setting properties of an MFMailComposeViewController instance.
            mailCompose.setSubject("Reg: Inquiry regarding")
    
            mailCompose.setMessageBody("Hi,"+"\n"+"I would like to inquire about event "+"\(String(describing: self.model.event[indexPath.row].title!))"+". Could you please provide me more information about it?", isHTML: false)
            
            
            // check to make sure the device can send e-mail at this moment
            if MFMailComposeViewController.canSendMail(){
                // If it can, present the configured MFMailComposeViewController
                self.present(mailCompose, animated: true, completion: nil)
                
            }
            else{
                print("Error in sending mail...!")
            }
        }
        
        return [shareAction]
    }
    
    // MFMailComposeViewControllerDelegate Method
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - EventsTVC Refresh
    
    // Method that will refresh the TVC and fetch the latest data
    @IBAction func eventTVCRefresh(_ sender: UIRefreshControl) {
        
        refreshControl?.beginRefreshing()
        model.eventFetch()
        self.tableView.reloadData()
        refreshControl?.endRefreshing()
    }
    
}


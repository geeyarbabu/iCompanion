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

    var moodTimer: Timer!
   
    var model = ModelClass()
  
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func eventTVCRefresh(_ sender: UIRefreshControl) {
        
        refreshControl?.beginRefreshing()
        model.eventFetch()
        self.tableView.reloadData()
        refreshControl?.endRefreshing()
    }
    
    
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
    
    
    // as we have to present the mail view in the parent view, we have left the method in the controller
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let shareAction = UITableViewRowAction(style: .normal, title:"Mail the Organiser") { (action: UITableViewRowAction!, indexPath: IndexPath!) -> Void in
            
            
            let mailCompose = MFMailComposeViewController()
            
            
            mailCompose.mailComposeDelegate = self
            
            
            mailCompose.setToRecipients([self.model.event[indexPath.row].email!])
            
            
            mailCompose.setSubject("Reg: Inquiry regarding")
            
            
            mailCompose.setMessageBody("Hi,"+"\n"+"I would like to inquire about event "+"\(String(describing: self.model.event[indexPath.row].title!))"+". Could you please provide me more information about it?", isHTML: false)
            
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


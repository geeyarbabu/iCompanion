//
//  EventsTVC.swift
//  iCompanion
//
//  Created by gEeYaR's MacBook Pro on 21/04/2017.
//  Copyright © 2017 UCD. All rights reserved.
//

import UIKit
import MessageUI

class EventsTVC: UITableViewController, MFMailComposeViewControllerDelegate {

    
    var event : [Event] = []
    
  
    override func viewDidLoad() {
        super.viewDidLoad()

    
              // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    
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
    
    var event_data = Event()
    var mail : String = " "
    
    static func sendMail()
    {
       // mail = event_data.email!
        let mailCompose = MFMailComposeViewController()
        
        
        mailCompose.mailComposeDelegate = self as? MFMailComposeViewControllerDelegate
        
        mailCompose.setToRecipients(["geeyarbabu@gmail.com"])
        
        // +  "\(String(describing: event_data.title))"
        mailCompose.setSubject("Reg: Inquiry regarding")
        
        //+"\n"+"I would like to inquire about event"+"\(String(describing: event_data.title))"+"Could you please provide me more information about it"
        mailCompose.setMessageBody("Hi,", isHTML: false)
        
        if MFMailComposeViewController.canSendMail(){
            
        }
        else{
            print("Hata...!")
        }
        
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


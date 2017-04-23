//
//  AdminTVC.swift
//  iCompanion
//
//  Created by gEeYaR's MacBook Pro on 21/04/2017.
//  Copyright © 2017 UCD. All rights reserved.
//

import UIKit
import CoreData


class AdminTVC: UITableViewController {
    
    @IBOutlet weak var event_title: UITextField!
    @IBOutlet weak var event_description: UITextField!
    @IBOutlet weak var house_number: UITextField!
    @IBOutlet weak var street_name: UITextField!
    @IBOutlet weak var event_city: UITextField!
    @IBOutlet weak var date_of_event: UITextField!
    @IBOutlet weak var phone_number: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var department: UIPickerView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
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
        return 9
    }
    
    @IBAction func addBtnPressed(_ sender: Any) {
        
        let container = UIApplication.shared.delegate as! AppDelegate
        let context = container.persistentContainer.viewContext
        
        let event = Event(context: context)
        
        event.title = event_title.text!
        event.event_description = event_description.text!
        event.house_no = house_number.text!
        event.street = street_name.text!
        event.city = event_city.text!
        event.date_of_event = date_of_event.text!
        event.phone_no = phone_number.text!
        event.email = email.text!
        event.department = "testing"
        
        container.saveContext()
        
        
        let alert = UIAlertController(title: "Saved", message: "Event Saved. Thanks for your participation", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in self.event_title.text = ""
            self.event_description.text = ""
            self.date_of_event.text = ""
            self.street_name.text = ""
            self.house_number.text = ""
            self.event_city.text = ""
            self.email.text = ""
            self.phone_number.text = ""
        }))
                self.present(alert, animated: true, completion: nil)
        
            }

}

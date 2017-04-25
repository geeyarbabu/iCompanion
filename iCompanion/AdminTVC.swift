//
//  AdminTVC.swift
//  iCompanion
//
//  Created by gEeYaR's MacBook Pro on 21/04/2017.
//  Copyright © 2017 UCD. All rights reserved.
//

import UIKit
import CoreData


class AdminTVC: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    var model = ModelClass()
    
    @IBOutlet weak var event_title: UITextField!
    @IBOutlet weak var event_description: UITextField!
    @IBOutlet weak var house_number: UITextField!
    @IBOutlet weak var street_name: UITextField!
    @IBOutlet weak var event_city: UITextField!
    @IBOutlet weak var date_of_event: UITextField!
    @IBOutlet weak var phone_number: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var department: UITextField!
  
//    var dept = ["Computer Science" , "Engineering" , "Science", "Electronics"]
//    let picker = UIPickerView()

    override func viewDidLoad() {
        super.viewDidLoad()
        model.picker.delegate = self
        model.picker.dataSource = self
        department.inputView = model.picker
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return model.dept.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return model.dept[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        department.text = model.dept[row]
        self.view.endEditing(false)
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
        
        model.saveEvent(event_title: event_title.text!, event_description: event_description.text!, house_number: house_number.text!, street_name: street_name.text!, event_city: event_city.text!, date_of_event: date_of_event.text!, phone_number: phone_number.text!, email: email.text!, department: department.text!)
        
        
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

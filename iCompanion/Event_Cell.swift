//
//  Event_Cell.swift
//  iCompanion
//
//  Created by gEeYaR's MacBook Pro on 22/04/2017.
//  Copyright © 2017 UCD. All rights reserved.
//

import UIKit

class Event_Cell: UITableViewCell {

    @IBOutlet weak var event_title: UILabel!
    
    @IBOutlet weak var event_description: UILabel!
    var event_data = Event() {
        didSet {
            refreshCell()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func refreshCell()
    {
        event_title.text = event_data.title!
        event_description.text = event_data.event_description!
    }
    

}

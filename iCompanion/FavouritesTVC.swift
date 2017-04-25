//
//  FavouritesTVC.swift
//  iCompanion
//
//  Created by gEeYaR's MacBook Pro on 23/04/2017.
//  Copyright © 2017 UCD. All rights reserved.
//

import UIKit

class FavouritesTVC: UITableViewController {

    
    @IBOutlet var favTable: UITableView!
    
    let model = ModelClass()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
       model.fetchFavourites()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        return model.favo.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "favCell", for: indexPath) as! FavCell

        // Configure the cell...
        
       
        cell.favData = model.favo[indexPath.row]
        
        return cell
    }


    
    
    @IBAction func refreshingFavouriteTVC(_ sender: UIRefreshControl) {
        refreshControl?.beginRefreshing()
        model.fetchFavourites()
        self.favTable.reloadData()
        refreshControl?.endRefreshing()
        
    }
    

}


class FavCell:  UITableViewCell{
    
    @IBOutlet weak var favTitle: UILabel!
    @IBOutlet weak var favDetails: UILabel!
    @IBOutlet weak var favDate: UILabel!
    
    
    var favData = Favourites(){
        didSet{
            populateCell()
        }
    }
    
    func populateCell()
    {
        favTitle.text = favData.event_title!
        favDate.text = favData.event_date!
        favDetails.text = favData.event_description!
        
    }
}

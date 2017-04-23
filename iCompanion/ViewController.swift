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

class ViewController: UIViewController, GIDSignInUIDelegate {
    
    //var getMood: Timer!
    
    @IBOutlet weak var signInButton: GIDSignInButton!
    
     @IBOutlet weak var adminBtnPressed: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //getMood = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(displayAlert), userInfo: nil, repeats: true)
        // Do any additional setup after loading the view, typically from a nib.
        
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()
        
        
        
    }
    
        override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func adminBtnPressed(_ sender: UIButton) {
        
    }
   

}


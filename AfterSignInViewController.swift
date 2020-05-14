//
//  AfterSignInViewController.swift
//  specialTopicSem4
//
//  Created by Anantha Krishna on 22/03/20.
//  Copyright © 2020 Anantha Krishna. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class AfterSignInViewController: UIViewController {

    
    
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var powerValue: UILabel!
    
    @IBOutlet weak var toggleValue: UILabel!
    
    var ref:DatabaseReference!
    var data:FirebaseData?
    var powerString:String?
    var toggleString:String?
    var timer:Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        getFirebaseData(ref)
        // change the delay to 1s but proceed with caution
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (Timer) in
             print("Inside dispatch ",self.powerString)
                       if let powerString = self.powerString
                       {
                           print("typecasted\n")
                           self.powerValue.text! = powerString
                           self.toggleValue.text! = self.toggleString!
                           self.getStatus()
                    
                           
                       }
            self.getFirebaseData(self.ref)
        })

    }
    
    func getStatus(){
        if (Double(self.powerString!) == 0.0)
        {
            if(self.toggleString! == "On")
            {
                self.statusLabel.text! = "Fused"
            }
            else if(self.toggleString! == "Off"){
                self.statusLabel.text! = "Normal"
            }
            else {
                self.statusLabel.text! = "Functioning in Auto Mode"
            }
        }
        else
        {
            if(self.toggleString! == "On"){
                self.statusLabel.text! = "Normal"
            }
            else if(self.toggleString! == "Off"){
                self.statusLabel.text! = "Switch Faulty"
            }
            else {
                self.statusLabel.text! = "Functioning in Auto Mode"
            }
        }
    }
    
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        if(sender.titleLabel?.text! != "Button Disabled")
        {
         performSegue(withIdentifier: "ChartViewSegue", sender: self)
        }
    }
    
    @IBAction func toggleSwitchPressed(_ sender: Any) {
        if(self.toggleString == "On")
        {
            self.ref.child("Power").setValue(0.0)
            self.ref.child("Toggle").setValue("Off")
        }
        else if(self.toggleString == "Off")
        {
            // change that value to float if needed
          self.ref.child("Power").setValue(5.0)
          self.ref.child("Toggle").setValue("Auto")
        }
        else
        {
            // change that value to float if needed
          self.ref.child("Power").setValue(5.0)
          self.ref.child("Toggle").setValue("On")
        }
        
        
    }
    @objc func display(){
        
//                    print("Inside dispatch ",self.powerString)
                   if let powerString = self.powerString
                   {
//                       print("typecasted\n")
                       self.powerValue.text! = powerString
                       self.toggleValue.text! = self.toggleString!
                       
                   }
    }
    
    
    
    
    func getFirebaseData(_ ref:DatabaseReference)
    {
        ref.child("Power").observeSingleEvent(of: .value) { (DataSnapshot) in
            let val:Double?
//            print(DataSnapshot.value)
            val = DataSnapshot.value as? Double
            if let val = val{
                self.powerString = String(val)
            }

        }
        ref.child("Toggle").observeSingleEvent(of: .value) { (DataSnapshot) in
            
            let val:String?
//            print(DataSnapshot.value)
            val = DataSnapshot.value as? String
            if let val = val{
                self.toggleString = val
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "ChartViewSegue")
        {
            // no data to be passed from this view to the other so this is empty
        }
    }
    

  

}

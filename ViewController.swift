//
//  ViewController.swift
//  specialTopicSem4
//
//  Created by Anantha Krishna on 02/03/20.
//  Copyright © 2020 Anantha Krishna. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase
import GoogleSignIn
import FirebaseAuth

class ViewController: UIViewController,GIDSignInDelegate{
    

    @IBOutlet weak var signInButton:GIDSignInButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().delegate = self
        // Do any additional setup after loading the view.
    }
    
   
    @IBAction func signInButtonPressed(_ sender: Any) {
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().signIn()
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
         // ...
         if let error = error {
            print(error.localizedDescription)
           return
         }

         guard let authentication = user.authentication else { return }
         let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,accessToken: authentication.accessToken)
         
        Auth.auth().signIn(with: credential) { (AuthDataResult, Error) in
            if let error = Error{
            print(error)
            }

//            print(user.profile.name)
//            print(user.profile.familyName)
        }
           

        print("Successfully signed in using google")
        
        self.dismiss(animated: true) {
         self.performSegue(withIdentifier: "Test", sender: self)
        }
        
           // MARK: Firebase Sign In
           
       }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Test"
        {
// no data required to be passed
//            let destinationVC = segue.destination as! AfterSignInViewController

        }
        
        
    }
    func moveToNextView()
    {
        self.performSegue(withIdentifier: "Test", sender: self)
    }
    

}
    



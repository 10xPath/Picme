//
//  SigninViewController.swift
//  Picme
//
//  Created by John Nguyen on 4/4/15.
//  Copyright (c) 2015 John Nguyen. All rights reserved.
//

import UIKit
import Parse

class SigninViewController: UIViewController {

    @IBOutlet weak var usernameTextfield: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func signin(sender: UIButton) {
        self.view.endEditing(true);
        let username : NSString = usernameTextfield.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        let password : NSString = passwordTextField.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).MD5()
        if(username.length == 0 && password.length == 0){
            
        }else{
            PFUser.logInWithUsernameInBackground(username as String, password:password as String) {
                (user, error) -> Void in
                if user != nil {
                    print("To Feed")
                    
                    self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
                } else {
                    // The login failed. Check error to see why.
                }
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true);

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

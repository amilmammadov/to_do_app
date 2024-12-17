//
//  SignUpPageViewController.swift
//  LoginAnimationLottie
//
//  Created by Amil Mammadov on 14.12.24.
//

import UIKit

class SignUpPageViewController: UIViewController {
    
    var context = AppDelegate().persistentContainer.viewContext

    @IBOutlet var nameField: UITextField!
    @IBOutlet var surnameField: UITextField!
    @IBOutlet var phoneNumberField: UITextField!
    @IBOutlet var jobTitleField: UITextField!
    @IBOutlet var usernameField: UITextField!
    @IBOutlet var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true

    }
    
    @IBAction func saveData(_ sender: Any) {
        if let name = nameField.text,
           let surname = surnameField.text,
           let phoneNumber = phoneNumberField.text,
           let jobTitle = jobTitleField.text,
           let username = usernameField.text,
           let password = passwordField.text {
            
            let userModel = UserData(context:context)
            userModel.name = name
            userModel.surname = surname
            userModel.phoneNumber = phoneNumber
            userModel.jobTitle = jobTitle
            userModel.username = username
            userModel.password = password
            
            do{
                try context.save()
                navigationController?.popViewController(animated: true)
            }catch{
                print(error.localizedDescription)
            }
            
            
        }
        
    }
}

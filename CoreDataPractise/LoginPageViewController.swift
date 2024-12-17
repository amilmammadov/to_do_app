//
//  ViewController.swift
//  LoginAnimationLottie
//
//  Created by Amil Mammadov on 14.12.24.
//

import UIKit
import Lottie
import CoreData


class LoginPageViewController: UIViewController {

    @IBOutlet var userPasswordField: UITextField!
    @IBOutlet var userNameField: UITextField!
    @IBOutlet var loginAnimationView: LottieAnimationView!
    
    var userHelp = [Help]()
    var userData = [UserData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let loginAnimation = LottieAnimation.named("LoginAnimation")
        loginAnimationView.animation = loginAnimation
        loginAnimationView.loopMode = .loop
        loginAnimationView.animationSpeed = 1
        loginAnimationView.play()
        
        userNameField.placeholder = "Enter username"
        userPasswordField.placeholder = "Enter password"
        
    }

    @IBAction func loginButton(_ sender: Any) {
        fetchUserData()
        if userData.contains(where: {$0.username == userNameField.text && $0.password == userPasswordField.text}){
            if let sceneDelegate = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate){
                UserDefaults.standard.set(true, forKey: "isLoggedIn")
                sceneDelegate.setMainPageRootController()
            }
        }else{
            let actionSheetController = UIAlertController(title: nil, message: "Please enter the right username or password!", preferredStyle: .actionSheet)
            let exitAction = UIAlertAction(title: "Exit", style: .cancel)
            actionSheetController.addAction(exitAction)
            self.present(actionSheetController,animated: true)
            userNameField.text = ""
            userPasswordField.text = ""
        }
        }
    

    @IBAction func signUpButton(_ sender: Any) {
        let signUpPageViewController = storyboard?.instantiateViewController(identifier: "SignUpPageViewController") as! SignUpPageViewController
        navigationController?.show(signUpPageViewController, sender: nil)
        
    }
    
    @IBAction func getHelpButton(_ sender: Any) {
        Help.userHelpFunction(viewController: self)

    }
    
    func fetchUserData(){
        do{
            userData = try SignUpPageViewController().context.fetch(UserData.fetchRequest())
        }catch{
            print(error.localizedDescription)
        }
    }
    
    
}


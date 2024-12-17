//
//  Help.swift
//  LoginAnimationLottie
//
//  Created by Amil Mammadov on 14.12.24.
//

import Foundation
import UIKit

var userProblems = [Help]()

struct Help:Codable {
    let problem: String
    let fulName: String
    let phoneNumber: String
    
    static func userHelpFunction(viewController: UIViewController){
        let alertController = UIAlertController(title: "Help", message: "Please enter your problem below!", preferredStyle: .alert)
        alertController.addTextField { textfield in textfield.placeholder = "Enter your problem..."}
        alertController.addTextField {textfield in textfield.placeholder = "Add your name"}
        alertController.addTextField {textfield in textfield.placeholder = "Add phone number"}
        let exit = UIAlertAction(title: "Exit", style: .cancel)
        alertController.addAction(exit)
        let send = UIAlertAction(title: "Send", style: .default){ action in
            let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            let docPath = path[0]
            let jsonFile = docPath.appendingPathComponent("Help", conformingTo: .json)
            print(jsonFile)
            if let userProblem = alertController.textFields?[0].text,
               let userFullName = alertController.textFields?[1].text,
               let userPhoneNumber = alertController.textFields?[2].text{
                userProblems.append(Help(problem: userProblem, fulName: userFullName, phoneNumber: userPhoneNumber))
                do{
                    let encodedData = try JSONEncoder().encode(userProblems)
                    try encodedData.write(to: jsonFile)
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
        alertController.addAction(send)
        viewController.present(alertController, animated: true)
        
    }
}

//
//  MainPageViewController.swift
//  CoreDataPractise
//
//  Created by Amil Mammadov on 14.12.24.
//

import UIKit

class MainPageViewController: UIViewController {
    
    let context = AppDelegate().secondPersistentContainer.viewContext
    
    @IBOutlet var tableView: UITableView!
    
    var userActivities = [UserActivity]()
    var addedActivity = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUserActivity()
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    @IBAction func addActivityButton(_ sender: Any) {
        let alertController = UIAlertController(title: "Add Activity", message: "Enter your activity below", preferredStyle: .alert)
        alertController.addTextField { textfield in
            textfield.placeholder = "Enter here"
        }
        let exit = UIAlertAction(title: "Exit", style: .cancel)
        alertController.addAction(exit)
        let save = UIAlertAction(title: "Save", style: .default){_ in
            if let text = alertController.textFields?[0].text{
                self.addedActivity = text
                self.saveUserActivity()
            }
        }
        alertController.addAction(save)
        self.present(alertController,animated: true)
    }
    
    @IBAction func logOutButton(_ sender: Any) {
        if let sceneDelegate = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate) {
            UserDefaults.standard.set(false, forKey: "isLoggedIn")
            sceneDelegate.setLoginPageRootController()
        }
    }
    
    func fetchUserActivity(){
        do{
            userActivities = try context.fetch(UserActivity.fetchRequest())
            tableView.reloadData()
        }catch{
            print(error.localizedDescription)
        }
    }
    func saveUserActivity(){
        let userActivityModel = UserActivity(context: context)
        userActivityModel.activity = addedActivity
        userActivityModel.id = Int16(userActivities.count + 1)
        do{
            try context.save()
            fetchUserActivity()
        }catch{
            print(error.localizedDescription)
        }
        
    }
    
}

extension MainPageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        userActivities.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        if let text = userActivities[indexPath.row].activity{
            cell.textLabel?.text = "\(indexPath.row + 1). \(text)"
        }
        return cell
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: nil){_,_,_ in
            
            let editedActivity = self.userActivities[indexPath.row]
            
            let alertController = UIAlertController(title: "Edit current activity", message: nil, preferredStyle: .alert)
            alertController.addTextField()
            let save = UIAlertAction(title: "Save", style: .default){ _ in
                if let text = alertController.textFields?[0].text {
                    editedActivity.activity = text
                    do {
                        try self.context.save()
                        self.fetchUserActivity()
                    }catch{print(error.localizedDescription)}
                }
            }
            alertController.addAction(save)
            self.present(alertController,animated: true)
        }
        editAction.image = UIImage(systemName: "pencil.circle.fill")?.withTintColor(.green, renderingMode: .alwaysOriginal)
        editAction.backgroundColor = .white
        let deleteAction = UIContextualAction(style: .normal, title: nil){_,_,_ in
            let deletedActivity = self.userActivities[indexPath.row]
            self.context.delete(deletedActivity)
            do{
                try self.context.save()
                self.fetchUserActivity()
            }catch{print(error.localizedDescription)}
        }
        deleteAction.image = UIImage(systemName: "trash.fill")?.withTintColor(.red, renderingMode: .alwaysOriginal)
        deleteAction.backgroundColor = .white
        let uISwipeActionsConfiguration = UISwipeActionsConfiguration(actions: [deleteAction,editAction])
        uISwipeActionsConfiguration.performsFirstActionWithFullSwipe = false
        return uISwipeActionsConfiguration
    }
    
    
}

//
//  ListController.swift
//  ComprendreLesAPI
//
//  Created by Mathieu @theunknowman_80 29/05/2023.
//

//This controller is quite different as it manages the display of various users generated by the API. It uses a custom cell that you can find in the "ListCell" view. The profiles are stored in a dictionary for temporary and asynchronous storage in the onDictReceived function. The rest is quite standard. I have added a custom profile for each randomly generated user, allowing you to click on each cell and navigate to a fictional profile that provides additional data about these users, using the UserProfil controller.

import UIKit

class ListController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var users: [User] = []
    var dict: [String: Any]!
    let id = "ListCell"
    let identifier = "toProfil"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        onDictReceveid()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func onDictReceveid() {
        let results = dict["results"] as? Int ?? 0
        let gender = dict["gender"] as? Gender ?? .noGender
        APIHelper.shared.performRequest(results: results, gender: gender) { users in
            DispatchQueue.main.async {
                self.users = users
                self.tableView.reloadData()
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = users[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: id) as? ListCell {
            cell.setup(user)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = users[indexPath.row]
        performSegue(withIdentifier: identifier, sender: selectedItem)
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == identifier {
            if let detail = segue.destination as? UserProfil {
                detail.user = sender as? User
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
}

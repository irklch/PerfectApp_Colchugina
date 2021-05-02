//
//  FriendsTableViewController.swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 25.04.2021.
//

import UIKit

class FriendsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       print(Friends.list.count)
        return Friends.list.count
    }
    
    
   
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FriendsTableViewCell.reuseId, for: indexPath) as! FriendsTableViewCell
        let someFriend = Friends.list[indexPath.row]
        cell.config(name: someFriend.name, photo: someFriend.photo[0])
        return cell
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            segue.identifier == "FriendPhotosViewController",
            let destinationController = segue.destination as? FriendPhotosViewController,
            let index = tableView.indexPathForSelectedRow?.row
        else {
            return
        }
        destinationController.selectedFriend = index
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            Friends.list.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}

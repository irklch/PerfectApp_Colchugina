//
//  FriendsTableViewController.swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 25.04.2021.
//

import UIKit

class FriendsTableViewController: UITableViewController {
    private var friends = [[Friends]]()
    private var lettersSection = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var sortedFriends = Friends.list
        sortedFriends.sort { $0.name < $1.name }
        lettersSection = Array(Set(sortedFriends.map({ String($0.name.first ?? "*") }))).sorted()
        for letter in lettersSection {
            let someFriend = sortedFriendOnSection(letter, sortedFriends)
            friends.append(someFriend)
        }
        
    }
    func sortedFriendOnSection (_ letter: String, _ arr: [Friends]) -> [Friends] {
        return arr.filter { String($0.name.first ?? "*") == letter }
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return friends.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends[section].count
    }
    
    
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FriendsTableViewCell.reuseId, for: indexPath) as! FriendsTableViewCell
        let someFriend = friends[indexPath.section][indexPath.row]
        cell.config(name: someFriend.name, photo: someFriend.photo[0])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return lettersSection[section]
    }
    
   
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            segue.identifier == "FriendPhotosViewController",
            let destinationController = segue.destination as? FriendPhotosViewController,
            let index = tableView.indexPathForSelectedRow
        else {
            return
        }
       
        destinationController.selectedFriend = friends[index.section][index.row]
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            Friends.list.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}

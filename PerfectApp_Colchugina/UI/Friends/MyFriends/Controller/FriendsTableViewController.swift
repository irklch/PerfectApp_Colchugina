//
//  FriendsTableViewController.swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 25.04.2021.
//

import UIKit

class FriendsTableViewController: UITableViewController, UISearchBarDelegate {
    private var friends = [[Friends]]()
    private var lettersSection = [String]()
    @IBOutlet weak var searchBar: UISearchBar!
    private var friendsFromSearch = [Friends]()
    var searchActive: Bool {
        if searchBar.text!.isEmpty {
            return false
        }
        else {
            return true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        self.friendsFromSearch = Friends.list
        var sortedFriends = Friends.list
        sortedFriends.sort { $0.name < $1.name }
        lettersSection = Array(Set(sortedFriends.map({ String($0.name.first ?? "*") }))).sorted()
        for letter in lettersSection {
            let someFriend = sortedFriendOnSection(letter, sortedFriends)
            friends.append(someFriend)
        }
        tableView.register(HeaderSectionForFriendsTable.self, forHeaderFooterViewReuseIdentifier: HeaderSectionForFriendsTable.reuseId)
        if searchActive {
            let tapForHiddenKeybourd = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
            view.addGestureRecognizer(tapForHiddenKeybourd)
        }
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    func sortedFriendOnSection (_ letter: String, _ arr: [Friends]) -> [Friends] {
        return arr.filter { String($0.name.first ?? "*") == letter }
    }
    
    
    
    // MARK: - Table view data source
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if searchActive {
            return 1
        } else {
            return friends.count
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchActive {
            return friendsFromSearch.count
        } else {
            return friends[section].count
        }
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FriendsTableViewCell.reuseId, for: indexPath) as! FriendsTableViewCell
        if searchActive {
            let someFriend = friendsFromSearch[indexPath.row]
            cell.config(name: someFriend.name, photo: someFriend.photo[0])
            
        } else {
            let someFriend = friends[indexPath.section][indexPath.row]
            cell.config(name: someFriend.name, photo: someFriend.photo[0])
            
        }
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderSectionForFriendsTable.reuseId) as? HeaderSectionForFriendsTable
        if searchActive {
            header?.configure(title: "TOP NAME MATCHES")
        }
        else {
            let title = lettersSection[section]
            header?.configure(title: title)
            
            
        }
        return header
        
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        CGFloat.leastNormalMagnitude
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
    
    //MARK: - SearchBar Configurations
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.setShowsCancelButton(true, animated: true)
        friendsFromSearch = []
        
        for item in Friends.list {
            let itemString = "\(item.name)"
            if itemString.lowercased().contains(searchText.lowercased()) {
                friendsFromSearch.append(item)
            }
            
            self.tableView.reloadData()
            
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        view.endEditing(true)
    }
    
    
    
}

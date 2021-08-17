//
//  FriendsTableViewController.swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 25.04.2021.
//

import UIKit
import RealmSwift

final class FriendsTableViewController: UITableViewController {
    
    //MARK:- Private properties
    private var friendsLists = [Friends]()
    private var friendsSortLists = [[Friends]]()
    private var friendsReseveLists = [[Friends]]()
    private var lettersLists = [String]()
    private var lettersSortReserveLists = [String]()
    @IBOutlet private weak var searchBar: UISearchBar!

    //MARK:- Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConfigurations()
        setSearchBarPlaceholder()
    }
    
    //MARK:- Private methods
    
    @IBAction func unwindToFriendsAction(unwindSegue: UIStoryboardSegue) {}
    private func setConfigurations() {
        getFriendsList()
        delegate()
        registerHead()
    }
    
    private func getFriendsList() {
        let vkRequest = VKRequests()
        let mapping = MappingJson()
        vkRequest.getFriendList { [weak self] result in
            guard let self = self else {return}
            
            switch result{
            case .failure(let error):
                print (error)
            case .success(let friends):
                mapping.createNewFriendStruct(oldStruct: friends.response.items)
                
                DispatchQueue.main.async {
                    self.readRealm()
                    self.startSortItems()
                    self.tableView.reloadData()
                    
                }
            }
        }
    }
    private func readRealm() {
        let friendsRealmLists: Results<Friends>?
        do {
            let realm = try Realm()
            let friendsData = realm.objects(Friends.self)
            friendsRealmLists = friendsData
            guard let items = friendsRealmLists else {return}
            items.forEach { item in
                friendsLists.append(item)
            }
        } catch {
            print(error)
        }
    }
    
    
    private func registerHead() {
        tableView.register(HeaderSectionForFriendsTable.self,
                           forHeaderFooterViewReuseIdentifier: HeaderSectionForFriendsTable.reuseId)
    }
    
    @objc
    private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func sortFriendBySection (_ letter: String, _ arr: [Friends]) -> [Friends] {
        return arr.filter { String($0.lastName.first ?? "*") == letter }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return friendsSortLists.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsSortLists[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FriendsTableViewCell.reuseId,
                                                 for: indexPath) as! FriendsTableViewCell
        let someFriend = friendsSortLists[indexPath.section][indexPath.row]
        cell.config(firstName: someFriend.firstName, lastName: someFriend.lastName, photo: someFriend.photo)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderSectionForFriendsTable.reuseId) as? HeaderSectionForFriendsTable
        let title = lettersLists[section]
        header?.configure(title: title)
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
        else {return}
        friendsLists.forEach { item in
            if item.lastName == friendsSortLists[index.section][index.row].lastName
            {
                destinationController.selectedFriend = item
            }
        }
    }
}


//MARK:- Extension

extension FriendsTableViewController: UISearchBarDelegate{
    
    //MARK:- Private methods
    
    private var isSearchBarActive: Bool {
        if searchBar.text == nil {
            return false
        }
        else {
            return true
        }
    }
    
    private func delegate() {
        searchBar.delegate = self
    }
    
    private func startSortItems() {
        var friendsList = friendsLists
        friendsList.sort { $0.lastName < $1.lastName }
        lettersLists = Array(Set(friendsList.map({ String($0.lastName.first ?? "*") }))).sorted()
        lettersLists.forEach { letter in
            let friend = sortFriendBySection(letter, friendsList)
            friendsSortLists.append(friend)
        }
        
        if isSearchBarActive {
            let tapForHiddenKeybourd = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
            view.addGestureRecognizer(tapForHiddenKeybourd)
        }
        friendsReseveLists = friendsSortLists
        lettersSortReserveLists = lettersLists
    }

    private func setSearchBarPlaceholder() {
        searchBar.placeholder = "Search friend"
    }

    //MARK:- Public methods

    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.setShowsCancelButton(true, animated: true)
        var friendsSearch = [Friends]()
        for item in friendsLists {
            friendsSortLists.removeAll()
            lettersLists.removeAll()
            let itemString = "\(item.lastName) \(item.firstName)"
            if itemString.lowercased().contains(searchText.lowercased()) {
                friendsSearch.append(item)
            }
            friendsSortLists.append(friendsSearch)
            lettersLists.append("Search result")
            self.tableView.reloadData()
        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        friendsSortLists = friendsReseveLists
        lettersLists = lettersSortReserveLists
        view.endEditing(true)
        tableView.reloadData()
    }
}


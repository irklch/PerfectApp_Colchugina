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
    private var realmToken: NotificationToken?
    @IBOutlet private weak var searchBar: UISearchBar!

    //MARK:- Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureOperationDependency()
        delegate()
        registerHead()
        configureKeyboard()
        setSearchBarPlaceholder()
    }

    //MARK:- Public methods

    func addFriendsList(list: [Friends]) {
        self.friendsLists = list
    }

    func addSortedLists(friendsSortLists: [[Friends]],
                        friendsReseveLists: [[Friends]],
                        lettersLists: [String],
                        lettersSortReserveLists: [String]) {
        self.friendsSortLists = friendsSortLists
        self.friendsReseveLists = friendsReseveLists
        self.lettersLists = lettersLists
        self.lettersSortReserveLists = lettersSortReserveLists
    }

    //MARK:- Private methods

    @IBAction func unwindToFriendsAction(unwindSegue: UIStoryboardSegue) {}

    private func registerHead() {
        tableView.register(HeaderSectionForFriendsTable.self,
                           forHeaderFooterViewReuseIdentifier: HeaderSectionForFriendsTable.reuseId)
    }

    @objc
    private func dismissKeyboard() {
        view.endEditing(true)
    }

    private func configureOperationDependency() {
        let frinedsMakeApiDataOperation = FrinedsMakeApiDataOperation()
        let frinedsParsingDataOperation = FrinedsParsingDataOperation()
        let frinedsSaveDataInRealmOperation = FrinedsSaveDataInRealmOperation()
        let frinedsLoadDataFromRealmOperation = FrinedsLoadAndPairRealmOperation(viewController: self)
        let frinedsSortDataOnSectionsOperation = FrinedsSortDataOnSectionsOperation(viewController: self)

        OperationQueue.main.addOperation(frinedsMakeApiDataOperation)
        frinedsParsingDataOperation.addDependency(frinedsMakeApiDataOperation)
        OperationQueue.main.addOperation(frinedsParsingDataOperation)
        frinedsSaveDataInRealmOperation.addDependency(frinedsParsingDataOperation)
        OperationQueue.main.addOperation(frinedsSaveDataInRealmOperation)
        frinedsLoadDataFromRealmOperation.addDependency(frinedsSaveDataInRealmOperation)
        OperationQueue.main.addOperation(frinedsLoadDataFromRealmOperation)
        frinedsSortDataOnSectionsOperation.addDependency(frinedsLoadDataFromRealmOperation)
        OperationQueue.main.addOperation(frinedsSortDataOnSectionsOperation)
        OperationQueue.main.addOperation {
            self.tableView.reloadData()
        }
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
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderSectionForFriendsTable.reuseId)
        as? HeaderSectionForFriendsTable
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
            if item.id == friendsSortLists[index.section][index.row].id
            {
                destinationController.selectedFriend = item.id
            }
        }
    }

}


//MARK:- Extension

extension FriendsTableViewController: UISearchBarDelegate{


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

    private func configureKeyboard() {
        if isSearchBarActive {
            let tapForHiddenKeybourd = UITapGestureRecognizer(target: self,
                                                              action: #selector(UIInputViewController.dismissKeyboard))
            view.addGestureRecognizer(tapForHiddenKeybourd)
        }
    }

    private func setSearchBarPlaceholder() {
        searchBar.placeholder = "Search friend"
    }

}


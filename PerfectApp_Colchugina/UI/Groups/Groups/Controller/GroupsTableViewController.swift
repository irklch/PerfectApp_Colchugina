//
//  GroupsTableViewController.swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 25.04.2021.
//

import UIKit
import RealmSwift

final class GroupsTableViewController: UITableViewController {

    //MARK:- Private properties

    private var groupsList = [Groups]()
    private var realmToken: NotificationToken?

    //MARK:- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getGroupsList()
    }

    //MARK:- Private methods

    private func getGroupsList() {
        let vkRequest = VKRequests()
        let saving = RealmLoader()
        vkRequest.getGroupList { [weak self] result in
            guard let self = self else {return}
            switch result{
            case .failure(let error):
                print (error)
            case .success(let groups):
                saving.saveGroups(jsonItems: groups.response.items)
                DispatchQueue.main.async {
                    self.readRealm()
                    self.pairTableAndRealm()
                    self.tableView.reloadData()
                }
            }
        }
    }

    private func readRealm() {
        let groupsResults: Results<Groups>?
        do {
            let realm = try Realm()
            let groupsData = realm.objects(Groups.self)
            groupsResults = groupsData
            guard let items = groupsResults else {return}
            items.forEach { item in
                groupsList.append(item)
            }
        } catch {
            print(error)
        }
    }


    private func pairTableAndRealm() {
        guard let realm = try? Realm() else {return}
        let groups = realm.objects(Groups.self)
        realmToken = groups.observe { [weak self]  (changes: RealmCollectionChange) in
            guard let tableView = self?.tableView else {return}
            switch changes {
            case .initial: tableView.reloadData()
            case .update(_, let deletions, let insertions, let modifications):
                tableView.beginUpdates()
                tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
                                     with: .automatic)
                tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}),
                                     with: .automatic)
                tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),
                                     with: .automatic)
                tableView.endUpdates()
            case .error(let error):
                fatalError("\(error)")
            }
        }
    }

    //MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupsList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyGroupTableViewCell.reuseId, for: indexPath) as? MyGroupTableViewCell else {return UITableViewCell()}
        let someGroup = groupsList[indexPath.row]
        cell.config(name: someGroup.name, photo: someGroup.photo)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.setSelected(true, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

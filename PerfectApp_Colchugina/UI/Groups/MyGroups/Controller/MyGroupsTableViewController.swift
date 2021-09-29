//
//  GroupsTableViewController.swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 25.04.2021.
//

import UIKit
import RealmSwift
import PromiseKit

final class MyGroupsTableViewController: UITableViewController {

    //MARK:- Private properties

    private var groupsList = [Groups]()
    private var realmToken: NotificationToken?

    //MARK:- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        getGroupsFromNetwork()
            .then { groups -> Promise<Bool> in
                return self.saveGroupsInRealm(groupsList: groups)
            }.then { feedback -> Promise<[Groups]> in
                return self.readRealm()
            }.then { groups -> Promise<Bool> in
                return self.loadRealmData(groups: groups)
            }.then { feedback -> Promise<Bool> in
                return self.pairTableAndRealm()
            }.done { feedback in
                print(feedback)
            }.catch { error in
                print(error)
            }
    }

    private func getGroupsFromNetwork() -> Promise<GroupsResponse> {
        let (promise, resolver) = Promise<GroupsResponse>.pending()
        let vkRequest = VKRequests()
        vkRequest.getGroupList { result in
            switch result{
            case .failure(let error):
                resolver.reject(error)
            case .success(let groups):
                resolver.fulfill(groups)
            }
        }
        return promise
    }

    private func saveGroupsInRealm(groupsList: GroupsResponse) -> Promise<Bool> {
        let (promise, resolver) = Promise<Bool>.pending()
        let saving = RealmLoader()
        saving.saveGroups(jsonItems: groupsList.response.items)
        resolver.fulfill(true)
        return promise
    }

    private func readRealm() -> Promise<[Groups]> {
        let (promise, resolver) = Promise<[Groups]>.pending()
        var list = [Groups]()
        let groupsResults: Results<Groups>?
        do {
            let realm = try Realm()
            let groupsData = realm.objects(Groups.self)
            groupsResults = groupsData
            guard let items = groupsResults else {return promise}
            items.forEach { item in
                list.append(item)
            }
            resolver.fulfill(list)
        } catch {
            resolver.reject(error)
        }
        return promise
    }

    private func loadRealmData(groups: [Groups]) -> Promise<Bool> {
        let (promise, resolver) = Promise<Bool>.pending()
        groupsList = groups
        resolver.fulfill(true)
        return promise
    }


    private func pairTableAndRealm() -> Promise<Bool> {
        let (promise, resolver) = Promise<Bool>.pending()
        guard let realm = try? Realm() else {return promise}
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
                resolver.fulfill(true)
            case .error(let error):
                resolver.reject(error)
            }
        }
        return promise
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

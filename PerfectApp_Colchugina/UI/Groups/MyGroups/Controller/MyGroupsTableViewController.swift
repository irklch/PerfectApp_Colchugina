//
//  GroupsTableViewController.swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 25.04.2021.
//

import UIKit
import RealmSwift

final class MyGroupsTableViewController: UITableViewController {

    //MARK:- Private properties

    private var groupsList = [Groups]()

    //MARK:- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getGroupsList()
    }

    //MARK:- Private methods

    private func getGroupsList() {
        let vkRequest = VKRequests()
        let mapping = MappingJson()
        vkRequest.getGroupList { [weak self] result in
            guard let self = self else {return}

            switch result{
            case .failure(let error):
                print (error)
            case .success(let groups):
                mapping.createNewGoupsStruct(oldStruct: groups.response.items)
                
                DispatchQueue.main.async {
                    self.readRealm()
                    self.tableView.reloadData()
                }
            }
        }
    }

    private func readRealm() {
        let groupsRealmList: Results<Groups>?
        do {
            let realm = try Realm()
            let groupsData = realm.objects(Groups.self)
            groupsRealmList = groupsData
            guard let items = groupsRealmList else {return}
            items.forEach { item in
                groupsList.append(item)
            }
        } catch {
            print(error)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: MyGroupTableViewCell.reuseId, for: indexPath) as! MyGroupTableViewCell
        let someGroup = groupsList[indexPath.row]
        cell.config(name: someGroup.name, photo: someGroup.photo)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.setSelected(true, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

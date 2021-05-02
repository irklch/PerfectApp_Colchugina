//
//  GroupsTableViewController.swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 25.04.2021.
//

import UIKit

class MyGroupsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func addGroup(segue: UIStoryboardSegue) {
          
        guard
            segue.identifier == "addGroup",
            let sourceController = segue.source as? AllGroupsTableViewController,
            let index = sourceController.tableView.indexPathForSelectedRow
        else {
            return
        }

        let someGroup = Groups.allList[index.row]
        if !Groups.myList.contains(where: { $0.name == someGroup.name}) {
            Groups.myList.append(someGroup)
            tableView.reloadData()
        }
       
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
      
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return Groups.myList.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyGroupTableViewCell.reuseId, for: indexPath) as! MyGroupTableViewCell
        let someGroup = Groups.myList[indexPath.row]
        cell.config(name: someGroup.name, photo: someGroup.photo)
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            Groups.myList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    

}

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
        Groups.allList.remove(at: index.row)
       
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
        cell.selectionStyle = .none
        return cell
    }
    
    
   //right swipe button - delete
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        // delete
        let delete = UIContextualAction(style: .normal, title: "Delete") { (action, view, completionHandler) in
            Groups.allList.append(Groups.myList[indexPath.row])
            Groups.myList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
          completionHandler(true)
        }
        delete.image = UIImage(systemName: "trash")
        delete.backgroundColor = .red
        
        
        // swipe
        let swipe = UISwipeActionsConfiguration(actions: [delete])
        return swipe
        
      }
    
    
    //left swipe button - add new group
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // add new group
        
        let add = UIContextualAction(style: .normal, title: "add") { (action, view, completionHandler) in
            let VC1 = self.storyboard!.instantiateViewController(withIdentifier: "AllGroupsTableViewController") as! AllGroupsTableViewController
            self.navigationController!.pushViewController(VC1, animated: true)
          completionHandler(true)
        }
        add.image = UIImage(systemName: "plus")
        add.backgroundColor = .systemGreen
        
        // swipe
        let swipe = UISwipeActionsConfiguration(actions: [add])
        return swipe
      }

}

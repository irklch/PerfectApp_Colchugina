//
//  AllGroupsTableViewController.swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 02.05.2021.
//

import UIKit

class NewGroupsTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AllGroupTableViewCell.reuseId, for: indexPath) as! AllGroupTableViewCell
        return cell
    }
    
    
    
}

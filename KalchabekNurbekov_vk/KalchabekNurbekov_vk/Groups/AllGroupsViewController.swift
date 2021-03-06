//
//  TableViewController3.swift
//  KalchabekNurbekov_vk
//
//  Created by Kalchabek Nurbekov on 13.04.2022.
//

import UIKit

class AllGroupsViewController: UITableViewController {
    @IBOutlet var searchBarAllGroups: UISearchBar! {
        didSet {
        searchBarAllGroups.delegate = self
        }
    }
    
    var availableGroup = [
        Group(name: "Mandarin language", city: "Shangahi", image: .init(named: "mandarin")!),
        Group(name: "Love", city: "Paris", image: .init(named: "love")!),
        Group(name: "Football", city: "Madrid", image: .init(named: "football")!),
        Group(name: "Mandarin language", city: "Shangahi", image: .init(named: "mandarin")!),
        Group(name: "Love", city: "Paris", image: .init(named: "love")!),
        Group(name: "Football", city: "Madrid", image: .init(named: "football")!),
        Group(name: "Mandarin language", city: "Shangahi", image: .init(named: "mandarin")!),
        Group(name: "Love", city: "Paris", image: .init(named: "love")!),
        Group(name: "Football", city: "Madrid", image: .init(named: "football")!)
    ]
    
    var filteredAvailableGroup = [Group]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        filteredAvailableGroup = availableGroup

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filteredAvailableGroup.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "availableGroupCell", for: indexPath) as! AvailableGroupTableViewCell
        let availableGroup = filteredAvailableGroup[indexPath.row]
        cell.set(group: availableGroup)
        
       

        // Configure the cell...

        return cell
    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .insert
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .insert {
          
        }
    }


    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension AllGroupsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText .isEmpty {
            filteredAvailableGroup = availableGroup
        } else {
            filteredAvailableGroup = availableGroup.filter {$0.name.lowercased().contains(searchText.lowercased())}
        }
        tableView.reloadData()
    }
    
}

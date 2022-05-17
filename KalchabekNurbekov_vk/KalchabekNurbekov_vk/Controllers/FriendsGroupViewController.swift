//
//  TableViewController2.swift
//  KalchabekNurbekov_vk
//
//  Created by Kalchabek Nurbekov on 13.04.2022.
//

import UIKit

class FriendsGroupViewController: UITableViewController {
    @IBOutlet var searchBarMyGroup: UISearchBar! {
        didSet {
            searchBarMyGroup.delegate = self
        }
    }
    
    var groups = [
        Group(name: "В Контакте", city: "Москва", image: .init(named: "vkPhoto")!),
        Group(name: "ios developing", city: "Нью-Йорк", image: .init(named: "iosPhoto")!),
        Group(name: "English for IT", city: "London", image: .init(named: "englishPhoto")!),
        Group(name: "В Контакте", city: "Москва", image: .init(named: "vkPhoto")!),
        Group(name: "ios developing", city: "Нью-Йорк", image: .init(named: "iosPhoto")!),
        Group(name: "English for IT", city: "London", image: .init(named: "englishPhoto")!),
        Group(name: "В Контакте", city: "Москва", image: .init(named: "vkPhoto")!),
        Group(name: "ios developing", city: "Нью-Йорк", image: .init(named: "iosPhoto")!),
        Group(name: "English for IT", city: "London", image: .init(named: "englishPhoto")!)
        ]
    
    var filteredGroups = [Group]()
    var sortedGroups = [Character: [Group]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filteredGroups = groups
       // self.sortedFriends = sort(friends: MyFriends)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         self.navigationItem.leftBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filteredGroups.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as! GroupTableViewCell
        let group = filteredGroups[indexPath.row]
        cell.set(group: group)

        return cell
    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            filteredGroups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
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
extension FriendsGroupViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText .isEmpty {
            filteredGroups = groups
        } else {
            filteredGroups = groups.filter {$0.name.lowercased().contains(searchText.lowercased())}
            
        }
        tableView.reloadData()
    }
    
}

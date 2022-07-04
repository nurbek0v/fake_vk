//
//  TableViewController2.swift
//  KalchabekNurbekov_vk
//
//  Created by Kalchabek Nurbekov on 13.04.2022.
//

import UIKit
import Foundation

class FriendsGroupViewController: UITableViewController {
    @IBOutlet var searchBarMyGroup: UISearchBar! {
        didSet {
            searchBarMyGroup.delegate = self
        }
    }
    
    var MyGroups = [
        Group(name: "В Контакте", city: "Москва", image: .init(named: "vkPhoto")!),
        Group(name: "ios developing", city: "Нью-Йорк", image: .init(named: "iosPhoto")!),
        Group(name: "English for IT", city: "London", image: .init(named: "englishPhoto")!),
        Group(name: "В Контакте", city: "Москва", image: .init(named: "vkPhoto")!),
        Group(name: "ios developing", city: "Нью-Йорк", image: .init(named: "iosPhoto")!),
        Group(name: "English for IT2", city: "London", image: .init(named: "englishPhoto")!),
        Group(name: "В Контакте", city: "Москва", image: .init(named: "vkPhoto")!),
        Group(name: "ios developing", city: "Нью-Йорк", image: .init(named: "iosPhoto")!),
        Group(name: "English for IT3", city: "London", image: .init(named: "englishPhoto")!)
        ]
    
    var filteredGroups = [Group]()
    var sortedGroups = [Character: [Group]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.register(UINib(nibName: "FriendXibTableViewCell", bundle: nil), forCellReuseIdentifier: "FriendXibTableViewCell")
       
      self.sortedGroups = sort(group: MyGroups)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         self.navigationItem.leftBarButtonItem = self.editButtonItem
        self.navigationItem.leftBarButtonItem?.title = "Unfollow"
    }
    private func sort(group: [Group]) -> [Character: [Group]] {
        var groupDict = [Character: [Group]] ()
        MyGroups.forEach() { group in
            guard let firstChar = group.name.first else { return }
            if var thisCharGroup = groupDict[firstChar] {
                thisCharGroup.append(group)
                groupDict[firstChar] = thisCharGroup
            } else {
                groupDict[firstChar] = [group]
            }
            
        }
        return groupDict
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sortedGroups.keys.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        let keysSorted = sortedGroups.keys.sorted()
        let groups = sortedGroups[keysSorted[section]]?.count ?? 0
        return groups
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendXibTableViewCell", for: indexPath) as! FriendXibTableViewCell

        let firstChar = sortedGroups.keys.sorted()[indexPath.section]
        let groups = sortedGroups[firstChar]!
        let group: Group = groups[indexPath.row]
        cell.friendImageView.image = group.image
        cell.friendNameLabel.text = group.name
        cell.friendAgeLabel.text = group.city

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
            
            let firstChar = sortedGroups.keys.sorted()[indexPath.section]
            let groups = sortedGroups[firstChar]!
            let group: Group = groups[indexPath.row]
            let initialSectionCount = sortedGroups.keys.count
            
            MyGroups.removeAll() {$0.name == group.name}
            
            if (searchBarMyGroup.text ?? "").isEmpty {
                filteredGroups = MyGroups
            } else {
                filteredGroups = MyGroups.filter {$0.name.lowercased().contains(searchBarMyGroup.text!.lowercased())}
            }
            sortedGroups = sort(group: filteredGroups)
            if initialSectionCount - sortedGroups.keys.count == 0 {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            } else {
                tableView.deleteSections(IndexSet([indexPath.section]), with: .automatic)
            }
           
        }
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        String(sortedGroups.keys.sorted()[section].uppercased())
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
            filteredGroups = MyGroups
        } else {
            filteredGroups = MyGroups.filter {$0.name.lowercased().contains(searchText.lowercased())}
            
        }
        sortedGroups = sort(group: filteredGroups)
        tableView.reloadData()
    }
    
}

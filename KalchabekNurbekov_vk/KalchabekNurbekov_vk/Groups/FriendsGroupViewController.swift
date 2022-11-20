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

    var service = GroupsService()
    var response: GroupsResponse?
    var filtGroups = [Group]()
   // var filteredGroups = [Group]()
  //  var sortedGroups = [Character: [Group]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Title", size: 20)]
        tableView.backgroundColor = .clear
        view.backgroundColor = UIColor(named: "AccentColor")
        fetchGroups()
        tableView.register(UINib(nibName: "FriendXibTableViewCell", bundle: nil), forCellReuseIdentifier: "FriendXibTableViewCell")
       
    }
//    private func sort(group: [Group]) -> [Character: [Group]] {
//        var groupDict = [Character: [Group]] ()
//        MyGroups.forEach() { group in
//            guard let firstChar = group.name.first else { return }
//            if var thisCharGroup = groupDict[firstChar] {
//                thisCharGroup.append(group)
//                groupDict[firstChar] = thisCharGroup
//            } else {
//                groupDict[firstChar] = [group]
//            }
//
//        }
//        return groupDict
//    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
//        let keysSorted = sortedGroups.keys.sorted()
//        let groups = sortedGroups[keysSorted[section]]?.count ?? 0
        return filtGroups.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendXibTableViewCell", for: indexPath) as? FriendXibTableViewCell else { fatalError("can not cast cell") }

//        let firstChar = sortedGroups.keys.sorted()[indexPath.section]
//        let groups = sortedGroups[firstChar]!
//        let group: Group = groups[indexPath.row]
//        cell.friendImageView.image = group.image
//        cell.friendNameLabel.text = group.name
//        cell.friendAgeLabel.text = group.city
        cell.friendNameLabel.text = filtGroups[indexPath.row].name
        guard let imgUrl = URL(string: (filtGroups[indexPath.row].image!)) else { return cell }
        cell.friendImageView.load(url: imgUrl)
        cell.friendAgeLabel.text = filtGroups[indexPath.row].activity
       

        return cell
    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//
//            let firstChar = sortedGroups.keys.sorted()[indexPath.section]
//            let groups = sortedGroups[firstChar]!
//            let group: Group = groups[indexPath.row]
//            let initialSectionCount = sortedGroups.keys.count
//
//            MyGroups.removeAll() {$0.name == group.name}
//
//            if (searchBarMyGroup.text ?? "").isEmpty {
//                filteredGroups = MyGroups
//            } else {
//                filteredGroups = MyGroups.filter {$0.name.lowercased().contains(searchBarMyGroup.text!.lowercased())}
//            }
//            sortedGroups = sort(group: filteredGroups)
//            if initialSectionCount - sortedGroups.keys.count == 0 {
//                tableView.deleteRows(at: [indexPath], with: .automatic)
//            } else {
//                tableView.deleteSections(IndexSet([indexPath.section]), with: .automatic)
//            }
//
//        }
    }
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        String(sortedGroups.keys.sorted()[section].uppercased())
//    }


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
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchText .isEmpty {
//            filteredGroups = MyGroups
//        } else {
//            filteredGroups = MyGroups.filter {$0.name.lowercased().contains(searchText.lowercased())}
//
//        }
//        sortedGroups = sort(group: filteredGroups)
//        tableView.reloadData()
//    }
    
}
private extension FriendsGroupViewController {
    func fetchGroups() {
        service.loadGroups { result in
            switch result {
            case .success(let group):
                DispatchQueue.main.async {
                    self.response = group
                    //тут тоже вроде фильтруется
                    self.filtGroups = (self.response?.response.items
                                        .filter( { $0.name != "DELETED"} )
                                        .map( {Group(name: $0.name, image: $0.logo, activity: $0.activity)} ))!
    

                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

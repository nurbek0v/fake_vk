//
//  TableViewController.swift
//  KalchabekNurbekov_vk
//
//  Created by Kalchabek Nurbekov on 13.04.2022.
//

import UIKit

class FriendsListViewController: UITableViewController {

    
    var friends = [
        Friend(name: "Oscar Isaac", age: "43 года", avatar: UIImage(named: "OscarIsaac"), photos: [UIImage(named: "OscarIsaac"),UIImage(named: "OscarIsaac2"),UIImage(named: "OscarIsaac3")]),
        Friend(name: "Elon Mask", age: "50 года", avatar: UIImage(named: "ElonMask"), photos: [UIImage(named: "ElonMask"),UIImage(named: "ElonMask2"),UIImage(named: "ElonMask3")]),
        Friend(name: "Zendaya Maree", age: "25 года", avatar: UIImage(named: "ZendayaMaree"), photos: [UIImage(named: "ZendayaMaree"),UIImage(named: "ZendayaMaree2"),UIImage(named: "ZendayaMaree3")]),
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()


        self.navigationItem.leftBarButtonItem = self.editButtonItem
        self.navigationItem.leftBarButtonItem?.title = "Unfollow"
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return friends.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath) as! FriendTableViewCell
        let friend = friends[indexPath.row]
        cell.set(friend: friend)


        return cell
    }
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            friends.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "GoDetail" else { return }
        let destination = segue.destination as! FriendsPhotoViewController
        let indexPath = tableView.indexPathForSelectedRow!
            destination.photoArray = friends[indexPath.row].photos
            
        
        
    }
   

}

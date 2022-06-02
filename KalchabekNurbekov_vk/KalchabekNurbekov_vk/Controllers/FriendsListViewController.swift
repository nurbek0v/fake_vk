//
//  TableViewController.swift
//  KalchabekNurbekov_vk
//
//  Created by Kalchabek Nurbekov on 13.04.2022.
//
import UIKit
import Foundation

class FriendsListViewController: UITableViewController {
    @IBOutlet var searchBarFriends: UISearchBar! {
        didSet {
            searchBarFriends.delegate = self
        }
    }

    
    public var MyFriends = [
        
       Friend(name: "Oscar Isaac",
              age: "43 года",
              avatar: UIImage(named: "OscarIsaac"),
              photos: [UIImage(named: "OscarIsaac")!,
                    UIImage(named: "OscarIsaac2")!,
                    UIImage(named: "OscarIsaac3")!]),
        Friend(name: "Elon Mask",
               age: "50 года",
               avatar: UIImage(named: "ElonMask"),
               photos: [UIImage(named: "ElonMask")!,
                        UIImage(named: "ElonMask2")!,
                        UIImage(named: "ElonMask3")!]),
        Friend(name: "Zendaya Maree",
               age: "25 года",
               avatar: UIImage(named: "ZendayaMaree"),
               photos: [UIImage(named: "ZendayaMaree")!,
                        UIImage(named: "ZendayaMaree2")!,
                        UIImage(named: "ZendayaMaree3")!]),
        Friend(name: "Dwayne Johnson",
               age: "45 года",
               avatar: UIImage(named: "Dwayne Johnson"),
               photos: [UIImage(named: "Dwayne Johnson")!,
                        UIImage(named: "Dwayne Johnson")!,
                        UIImage(named: "Dwayne Johnson")!]),
        Friend(name: "Joe Biden",
               age: "18 года",
               avatar: UIImage(named: "Joe Biden"),
               photos: [UIImage(named: "Joe Biden")!,
                        UIImage(named: "Joe Biden")!,
                        UIImage(named: "Joe Biden")!]),
        Friend(name: "Jeff Bezos",
               age: "29 года",
               avatar: UIImage(named: "Jeff Bezos"),
               photos: [UIImage(named: "Jeff Bezos")!,
                        UIImage(named: "Jeff Bezos")!,
                        UIImage(named: "Jeff Bezos")!]),
        Friend(name: "LeBron James",
               age: "34 года",
               avatar: UIImage(named: "Lebron James"),
               photos: [UIImage(named: "Lebron James")!,
                        UIImage(named: "Lebron James")!,
                        UIImage(named: "Lebron James")!]),
        Friend(name: "Kylie Jenner",
               age: "17 года",
               avatar: UIImage(named: "Kylie Jenner"),
               photos: [UIImage(named: "Kylie Jenner")!,
                        UIImage(named: "Kylie Jenner")!,
                        UIImage(named: "Kylie Jenner")!]),
        Friend(name: "Kim Kardashian",
               age: "47 года",
               avatar: UIImage(named: "Kim_Kardashian"),
               photos: [UIImage(named: "Kim_Kardashian")!,
                        UIImage(named: "Kim_Kardashian")!,
                        UIImage(named: "Kim_Kardashian")!]),
        Friend(name: "Mark Zuckerberg",
               age: "35 года",
               avatar: UIImage(named: "Mark_Zuckerberg"),
               photos: [UIImage(named: "Mark_Zuckerberg")!,
                        UIImage(named: "Mark_Zuckerberg")!,
                        UIImage(named: "Mark_Zuckerberg")!]),
        
        ]
    var filteredFriends = [Friend]()
    var sortedFriends = [Character: [Friend]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "FriendXibTableViewCell", bundle: nil), forCellReuseIdentifier: "FriendXibTableViewCell")
        self.sortedFriends = sort(friends: MyFriends)


        self.navigationItem.leftBarButtonItem = self.editButtonItem
        self.navigationItem.leftBarButtonItem?.title = "Unfollow"
        
    }
    private func sort(friends: [Friend]) -> [Character: [Friend]] {
        var friendDict = [Character: [Friend]] ()
        friends.forEach() { friend in
            guard let firstChar = friend.name.first else { return }
            if var thisCharFriend = friendDict[firstChar] {
                thisCharFriend.append(friend)
                friendDict[firstChar] = thisCharFriend
            } else {
                friendDict[firstChar] = [friend]
            }
            
        }
        return friendDict
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sortedFriends.keys.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let keysSorted = sortedFriends.keys.sorted()
        let friends = sortedFriends[keysSorted[section]]?.count ?? 0
        return friends
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendXibTableViewCell", for: indexPath) as! FriendXibTableViewCell
        
        let firstChar = sortedFriends.keys.sorted()[indexPath.section]
        let friends = sortedFriends[firstChar]!
        let friend: Friend = friends[indexPath.row]
        cell.friendImageView.image = friend.avatar
        cell.friendNameLabel.text = friend.name
        cell.friendAgeLabel.text = friend.age
        
        


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
            
            let firstChar = sortedFriends.keys.sorted()[indexPath.section]
            let friends = sortedFriends[firstChar]!
            let friend = friends[indexPath.row]
            let initialSectionsCount = sortedFriends.keys.count
            
            MyFriends.removeAll() {$0.name == friend.name}
            
            if (searchBarFriends.text ?? "").isEmpty {
                filteredFriends = MyFriends
            } else {
                filteredFriends = MyFriends.filter { $0.name.lowercased().contains(searchBarFriends.text!.lowercased()) }
            }
            sortedFriends = sort(friends: filteredFriends)
            if initialSectionsCount - sortedFriends.keys.count == 0 {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            } else {
                tableView.deleteSections(IndexSet([indexPath.section]), with: .automatic)
            }
            
            
        }
    }

    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "GoDetail" else { return }
        let destination = segue.destination as! FriendsPhotoViewController
        let indexPath = tableView.indexPathForSelectedRow!
            destination.photoArray = MyFriends[indexPath.row].photos
            
        
        
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        String(sortedFriends.keys.sorted()[section])
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "GoDetail", sender: nil)
    }

}
extension FriendsListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText .isEmpty {
            filteredFriends = MyFriends
        } else {
            filteredFriends = MyFriends.filter {$0.name.lowercased().contains(searchText.lowercased())}
        }
        sortedFriends = sort(friends: filteredFriends)
        tableView.reloadData()
    }
}

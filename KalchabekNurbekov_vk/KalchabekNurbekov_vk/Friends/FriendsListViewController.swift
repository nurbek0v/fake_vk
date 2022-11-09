//
//  TableViewController.swift
//  KalchabekNurbekov_vk
//
//  Created by Kalchabek Nurbekov on 13.04.2022.
//
import UIKit

class FriendsListViewController: UITableViewController {
    @IBOutlet var searchBarFriends: UISearchBar! {
        didSet {
            searchBarFriends.delegate = self
        }
    }
   
    let service = FriendService()
    var response = [Item]()
    //var filtUsers = [Friend]()
   // var filteredFriends = [Friend]()
  // var sortedFriends = [Character: []]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "FriendXibTableViewCell", bundle: nil), forCellReuseIdentifier: "FriendXibTableViewCell")
        service.delegate = self
        service.loadUsers()

        
       
    }
    
//    private func sort(friends: [Friend]) -> [Character: [Friend]] {
//        var friendDict = [Character: [Friend]] ()
//        friends.forEach() { friend in
//            guard let firstChar = friend.name.first else { return }
//            if var thisCharFriend = friendDict[firstChar] {
//                thisCharFriend.append(friend)
//                friendDict[firstChar] = thisCharFriend
//            } else {
//                friendDict[firstChar] = [friend]
//            }
//
//        }
//        return friendDict
//    }
    
    
       

    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return response.count
     
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendXibTableViewCell", for: indexPath) as! FriendXibTableViewCell
        cell.friendNameLabel.text = response[indexPath.row].firstName
        cell.friendAgeLabel.text = String(response[indexPath.row].id)
        guard let imgUrl = URL(string: (response[indexPath.row].avatar!)) else { return cell }
        cell.friendImageView.load(url: imgUrl)
        
        
        
        
        return cell
    }
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
  //  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt //indexPath: IndexPath) {
//        if editingStyle == .delete {
//
//            let firstChar = sortedFriends.keys.sorted()[indexPath.section]
//            let friends = sortedFriends[firstChar]!
//            let friend = friends[indexPath.row]
//            let initialSectionsCount = sortedFriends.keys.count
//
//            MyFriends.removeAll() {$0.name == friend.name}
//
//            if (searchBarFriends.text ?? "").isEmpty {
//                filteredFriends = MyFriends
//            } else {
//                filteredFriends = MyFriends.filter { $0.name.lowercased().contains(searchBarFriends.text!.lowercased()) }
//            }
//            sortedFriends = sort(friends: filteredFriends)
//            if initialSectionsCount - sortedFriends.keys.count == 0 {
//                tableView.deleteRows(at: [indexPath], with: .automatic)
//            } else {
//                tableView.deleteSections(IndexSet([indexPath.section]), with: .automatic)
//            }
//
//
//        }
  //  }
    
    
    // MARK: - Navigation
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        super.prepare(for: segue, sender: sender)
//        guard segue.identifier == "GoDetail" else { return }
//        let destination = segue.destination as! FriendsPhotoViewController
//        let indexPath = tableView.indexPathForSelectedRow!
//        let firstChar = sortedFriends.keys.sorted()[indexPath.section]
//        let friends = sortedFriends[firstChar]!
//        let friend: Friend = friends[indexPath.row]
//        destination.photoArray = friend.photos
//
//
//
//    }
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        String(sortedFriends.keys.sorted()[section])
//    }
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "GoDetail", sender: nil)
//
//    }
    
}
extension FriendsListViewController: UISearchBarDelegate {
   func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchText .isEmpty {
//            filteredFriends = MyFriends
//        } else {
//            filteredFriends = MyFriends.filter {$0.name.lowercased().contains(searchText.lowercased())}
//        }
//        sortedFriends = sort(friends: filteredFriends)
//        tableView.reloadData()
    }
}
extension FriendsListViewController: FriendServiceDelegate {
    func didUpdateFrineds(items: [Item]) {
        DispatchQueue.main.async {
            self.response = items
            self.tableView.reloadData()
        }
    }
    
    func didFinishWithError(error: Error) {
        print("get error")
    }
    
    
}
//private extension FriendsListViewController {
//    func fetchUser() {
//        service.loadUsers { result in
//            switch result {
//            case .success(let friend):
//                DispatchQueue.main.async {
//                    self.response = friend
//                    //тут тоже вроде фильтруется
////                    self.filtUsers = (self.response?.response.items
////                     .filter( { $0.firstName != "DELETED" } )
////                     .map( {Friend(name: $0.firstName + " " + $0.lastName, avatar: $0.avatar, ownerId: $0.id, city: $0.city.title)} ))!
//
//
//                    self.tableView.reloadData()
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
//}

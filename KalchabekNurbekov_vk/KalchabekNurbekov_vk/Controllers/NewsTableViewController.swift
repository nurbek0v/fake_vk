//
//  NewsTableViewController.swift
//  KalchabekNurbekov_vk
//
//  Created by Kalchabek Nurbekov on 31.05.2022.
//

import UIKit

class NewsTableViewController: UITableViewController {
    let myPosts = [
        Post(postAvatar: UIImage(named: "vacuum")!, postName: "VACUUM", postDate: "today at 00:06", postText: "Для любого человека понятие «дом» значит гораздо больше, чем толкование в массивных словарях или современной Википедии. Это не только жилище, где можно поесть, поспать, принять душ и посмотреть телевизор. Но все же каждый вкладывает в это слово особый смысл. Для любого человека понятие «дом» значит гораздо больше, чем толкование в массивных словарях или современной Википедии. Это не только жилище, где можно поесть, поспать, принять душ и посмотреть телевизор. Но все же каждый вкладывает в это слово особый смысл.", postImage: UIImage(named: "House")!),
        Post(postAvatar: UIImage(named: "Dwayne Johnson")!, postName: "Dwayne Johnson", postDate: "yesterday at 23:06", postText: " I bought a new car today, check it  😂", postImage: UIImage(named: "auto1")!),
        Post(postAvatar: UIImage(named: "vacuum")!, postName: "VACUUM", postDate: "today at 00:06", postText: "Для любого человека понятие «дом» значит гораздо больше, чем толкование в массивных словарях или современной Википедии. Это не только жилище, где можно поесть, поспать, принять душ и посмотреть телевизор. Но все же каждый вкладывает в это слово особый смысл. ", postImage: UIImage(named: "House")!),
        Post(postAvatar: UIImage(named: "vacuum")!, postName: "VACUUM", postDate: "today at 00:06", postText: "Для любого человека понятие «дом» значит гораздо больше, чем толкование в массивных словарях или современной Википедии. Это не только жилище, где можно поесть, поспать, принять душ и посмотреть телевизор. Но все же каждый вкладывает в это слово особый смысл. ", postImage: UIImage(named: "House")!),
        Post(postAvatar: UIImage(named: "vacuum")!, postName: "VACUUM", postDate: "today at 00:06", postText: "Для любого человека понятие «дом» значит гораздо больше, чем толкование в массивных словарях или современной Википедии. Это не только жилище, где можно поесть, поспать, принять душ и посмотреть телевизор. Но все же каждый вкладывает в это слово особый смысл. ", postImage: UIImage(named: "House")!)
        
    
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 100
        //tableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsTableViewCell")

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myPosts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as! NewsTableViewCell

        cell.postAvatar.image = myPosts[indexPath.row].postAvatar
        cell.postName.text = myPosts[indexPath.row].postName
        cell.postDate.text = myPosts[indexPath.row].postDate
        cell.postText.text = myPosts[indexPath.row].postText
        cell.postImage.image = myPosts[indexPath.row].postImage

        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.reloadData()
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

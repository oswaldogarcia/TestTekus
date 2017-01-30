//
//  NotificationsTable.swift
//  TestTekus
//
//  Created by Oswaldo Garcia on 1/27/17.
//  Copyright © 2017 Oswaldo Garcia. All rights reserved.
//

import UIKit

class NotificationsTable: UITableViewController {
    
    var notifications : Array<Dictionary<String, Any>>?
    var apiManager = ApiManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        self.tableView.register(UINib(nibName: "NotificationViewCell", bundle: nil), forCellReuseIdentifier: "notificationCell")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (notifications?.count)!
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notificationCell", for: indexPath) as! NotificationViewCell
        
        let data = self.notifications?[indexPath.row]
        
        
        cell.setData(data: data!)
        
        
        return cell
    }
    
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            
            let alertController = UIAlertController(title: "Delete", message: "Are you sure you want to delete this alert?", preferredStyle: UIAlertControllerStyle.alert)
            
            let yesAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default) {
                (result : UIAlertAction) -> Void in
                
                
                let dataRow = self.notifications?[indexPath.row]
                let id = String(describing: dataRow!["NotificationId"]!) as String
                
                print(id)
                self.deleteNotification(id: id)
                self.notifications?.remove(at:indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                
                
                print("delete")
                
            }
            let noAction = UIAlertAction(title: "No", style: UIAlertActionStyle.default) {
                (result : UIAlertAction) -> Void in
                
                print("NO")
                
            }
            
            alertController.addAction(yesAction)
            alertController.addAction(noAction)
            self.present(alertController, animated: true, completion: nil)
            
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        
    }
    
    
    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    
    func deleteNotification (id: String){
        
        apiManager.deleteRequest(id:id)
        
    }
    @IBAction func refreshNotifications(_ sender: Any) {
        
        apiManager.request { (notifications) in
            
            self.notifications = notifications as? Array<Dictionary<String, Any>>
            
            self.tableView.reloadData()
            
        }
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

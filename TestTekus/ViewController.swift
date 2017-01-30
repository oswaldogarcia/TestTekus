//
//  ViewController.swift
//  TestTekus
//
//  Created by Oswaldo Garcia on 1/27/17.
//  Copyright © 2017 Oswaldo Garcia. All rights reserved.
//

import UIKit
import CoreMotion
import CoreLocation
import Alamofire

class ViewController: UIViewController {
    
    var movementManager = CMMotionManager()
    var locationManager = CLLocationManager()
    var date1: Date?
    var postNoti: Bool = false
    var notificationId : Int = 0
    let apiManger = ApiManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.detectMotion()
        
        locationManager.startUpdatingLocation()
        
        self.locationManager.allowsBackgroundLocationUpdates = true
        
    }
    
    func detectMotion (){
        
        if movementManager.isAccelerometerAvailable {
            movementManager.accelerometerUpdateInterval = 0.1
            movementManager.startAccelerometerUpdates(to: OperationQueue.current!) { (accelerometerData: CMAccelerometerData?, NSError) -> Void in
                
                
                let x = accelerometerData!.acceleration.x
                let y = accelerometerData!.acceleration.y
                let z = accelerometerData!.acceleration.y
                
                let mov = 0.05
                
                if (x > mov || x < -mov || y > mov || y < -mov  || z > mov || z < -mov) {
                    
                    if ((self.date1) == nil){
                        
                        self.date1 = Date()
                        
                    }
                    print("moviento")
                    
                    if (self.calcSec(date: self.date1!)>2)
                    {
                        if (!self.postNoti){
                            
                            print("mayor a 2 sec")
                            
                            self.postNotification(date: self.date1!)
                            self.postNoti = true
                            
                        }
                        
                    }
                    
                }else{
                    
                    if ((self.date1) != nil){
                        
                        self.calcTime(date: self.date1!)
                        self.date1 = nil
                        self.postNoti = false
                    }
                    
                }
                if(NSError != nil) {
                    print("\(NSError)")
                }
            }
        }
        
        
    }
    
    func calcTime(date:Date){
        
        let interval = Date().timeIntervalSince(date)
        
        let duration = Int(interval)
        
        if (duration > 2){
            
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let dateString = dateFormatter.string(from: date)
        
            if(self.notificationId > 0){
            self.putNotification(date:dateString,duration: duration)
            }
        }
    }
    
    
    func calcSec(date:Date)->Int{
        
        let interval = Date().timeIntervalSince(date)
        
        let duration = Int(interval)
        
        return duration
        
    }
    
    func postNotification (date: Date){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = dateFormatter.string(from: date)
        
        let parameters : Parameters = [
            "NotificationId":0,
            "Date": dateString,
            "Duration": self.calcSec(date: date)
        ]
        
        apiManger.postRequest(parameters: parameters) { (result) in
            
            //print(result["NotificationId"] as! Int)
            self.notificationId = result["NotificationId"] as! Int
            
        }
    }
    
    func putNotification (date: String ,duration: Int){
        
        if(self.notificationId > 0){
            let parameters : Parameters = [
                "NotificationId":self.notificationId,
                "Date": date,
                "Duration": duration
            ]
            
            apiManger.putRequest(parameters: parameters,id:String(self.notificationId))
            
            self.notificationId = 0
            
        }
       
    }
    
    @IBAction func toNotificationsAction(_ sender: Any) {
        
        apiManger.request { (notifications) in
            
            self.performSegue(withIdentifier: "toNotifications", sender:notifications)
            
        }
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toNotifications" {
            
            
            if let nextVC = segue.destination as? NotificationsTable {
                nextVC.notifications = sender as? Array
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


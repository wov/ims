//
//  NotificationHelper.swift
//  IMS
//
//  Created by wov on 2021/3/28.
//

//import Foundation
import UserNotifications

struct NotificationHelper{
    
    static func getNotificationStatus() -> Bool{
        
        var notificationPermission: Bool = false
        
        let current = UNUserNotificationCenter.current()
                current.getNotificationSettings(completionHandler: { permission in
                    switch permission.authorizationStatus  {
                    case .authorized:
                        print("User granted permission for notification")
                        notificationPermission = true
                    case .denied:
                        print("User denied notification permission")
                        notificationPermission = false
                    case .notDetermined:
                        print("Notification permission haven't been asked yet")
                        notificationPermission = false
                    case .provisional:
                        // @available(iOS 12.0, *)
                        notificationPermission = false
                        print("The application is authorized to post non-interruptive user notifications.")
                    case .ephemeral:
                        // @available(iOS 14.0, *)
                        notificationPermission = false
                        print("The application is temporarily authorized to post notifications. Only available to app clips.")
                    @unknown default:
                        notificationPermission = false
                        print("Unknow Status")
                    }
                })
        
        return notificationPermission
        
    }
    
    static func askForPermission(requestType:Bool , completion: @escaping (Result<Bool, Error>) -> ()){
        let center = UNUserNotificationCenter.current()
        if requestType {
            center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                if let error = error {
                    // Handle the error here.
                    completion(.failure(error))
                }
                completion(.success(true))
            }
        }else{
            center.removeAllDeliveredNotifications()
            completion(.success(false))
        }
    }
    
    
    
    
}

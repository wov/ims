//
//  NotificationHelper.swift
//  IMS
//
//  Created by wov on 2021/3/28.
//

//import Foundation
import UserNotifications


enum notificationAuthorError: Error{
    case denied,notDetermined,provisional,ephemeral,unknow
}


struct NotificationHelper{
    
    static func getNotificationStatus( completion: @escaping (Result<Bool, notificationAuthorError>) -> ()){
        
//        var notificationPermission: Bool = false
        
        DispatchQueue.main.async {

        
        let current = UNUserNotificationCenter.current()
                current.getNotificationSettings(completionHandler: { permission in
                    
//                    print(permission)
                    
                    
                    switch permission.authorizationStatus  {
                    case .authorized:
                        print("User granted permission for notification")
//                        notificationPermission = true
                        completion(.success(true))
                    case .denied:
                        print("User denied notification permission")
//                        notificationPermission = false
                        completion(.failure(.denied))

                    case .notDetermined:
                        print("Notification permission haven't been asked yet")
                        completion(.failure(.notDetermined))

//                        notificationPermission = false
                    case .provisional:
                        // @available(iOS 12.0, *)
//                        notificationPermission = false
                        completion(.failure(.provisional))
                        print("The application is authorized to post non-interruptive user notifications.")
                    case .ephemeral:
                        // @available(iOS 14.0, *)
//                        notificationPermission = false
                        completion(.failure(.ephemeral))
                        print("The application is temporarily authorized to post notifications. Only available to app clips.")
                    @unknown default:
                        completion(.failure(.unknow))
//                        notificationPermission = false
                        print("Unknow Status")
                    }
                })
        
//        return notificationPermission
        }
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
            // TODO: if removed the notifacation ,can not open it again...
            center.removeAllDeliveredNotifications()
            completion(.success(false))
        }
    }
    
    
    
    
}

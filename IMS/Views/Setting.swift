//
//  Setting.swift
//  IMS
//
//  Created by wov on 2021/3/28.
//

//import Foundation
import SwiftUI

struct Setting: View {
    
    @State private var hasNotifacationPermission = false
    
    
    var body: some View {
        
        NavigationView{
            List{
                HStack{
                    VStack(alignment: .leading){
                        Text("允许通知")
                        Text("通知库存预警")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    Toggle("", isOn: $hasNotifacationPermission)
                        .onChange(of: hasNotifacationPermission) { requestType in
                            // action...
                            NotificationHelper.askForPermission(requestType: requestType, completion: { result in
                                switch result {
                                case .success:
                                    self.hasNotifacationPermission = true
                                case .failure:
                                    print("fail")
                                }
                                
                            })
                            
                        }
                }
                
            }.navigationTitle("设置")
        }.onAppear{
            let notificationPermission: Bool = NotificationHelper.getNotificationStatus()
            switch notificationPermission{
            case true:
                self.hasNotifacationPermission = true
            case false:
                self.hasNotifacationPermission = false
            }
        }
        
        
        
    }
}

struct Setting_Previews: PreviewProvider {
    
    
    static var previews: some View {
        Setting()
        
    }
}
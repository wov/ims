//
//  Setting.swift
//  IMS
//
//  Created by wov on 2021/3/28.
//

//import Foundation
import SwiftUI
import CloudKit

struct Setting: View {
    
    @State private var hasNotifacationPermission = false
    @State private var showCloudShare = false
    
    
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
                
                
                HStack(){
                    Text("添加成员")
                    Spacer()
                    Button("add",action:{
                        self.showCloudShare = true
                        //                        let user = CKUserIdentity.LookupInfo(emailAddress: "contact@inactstudio.com")
                        //                        CloudKitHelper().fetchParticipants(for: [user]){ result in
                        //                            switch result{
                        //                            case .success(let participants):
                        //                                for par in participants{
                        //                                    CloudKitHelper().addParticipant(par: par)
                        //                                }
                        //                                break;
                        //                            case .failure(let err):
                        //                                print(err)
                        //                                break
                        //
                        //
                        //                            }
                        //
                        //                        }
                        
                        
                    })
                }
            }.navigationTitle("设置")
        }.onAppear{
            NotificationHelper.getNotificationStatus(){ result in
                switch result {
                case .success:
                    self.hasNotifacationPermission = true
                case .failure:
                    print("fail")
                }
            }
        }.sheet(isPresented: $showCloudShare){
            CloudSharingController(isShowing: $showCloudShare)
                .frame(width: 0, height: 0)
        }
    }
}

struct Setting_Previews: PreviewProvider {
    static var previews: some View {
        Setting()
        
    }
}

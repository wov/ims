//
//  StoreList.swift
//  IMS
//
//  Created by wov on 2021/4/24.
//
import SwiftUI

struct StoreList : View {
    @EnvironmentObject var modelData: ModelData
    @State private var showAlert = false
//    @State private var loading = true
    @State private var showAddGood: Bool = false
    
    var body: some View{
        NavigationView{
                VStack{
                    if modelData.stores.isEmpty {
                        EmptyList()
                    }else{
                        
                    
                        List{
                            ForEach(modelData.stores){ store in
                                NavigationLink(
                                    destination: StoreDetail(currentStore: store)){
                                    StoreRow(store: store)
                                }
                                
                                
                            }
                        }  
                    }
                } .navigationTitle("仓库列表")
//                .navigationBarItems(trailing: Button(action: {
//                    self.showAddGood.toggle()
//                }){
//                    Text("添加商品")
//                })
        }.onAppear{
            //添加cloudkit订阅
            modelData.fetchStores(){ result in
                
            }
        }
    }
}

struct StoreList_Preview : PreviewProvider{
    static var previews: some View{
        StoreList()
            .environmentObject(ModelData())
    }
}

//
//  GoodList.swift
//  IMS
//
//  Created by wov on 2021/2/12.
//

import SwiftUI

struct GoodList : View {
    @EnvironmentObject var modelData: ModelData
    
    var currentStore: Store
    
    @State private var showAlert = false
    @State private var loading = true
    @State private var showAddGood: Bool = false
    
    
    var body: some View{
        NavigationView{
            if self.loading{
                ProgressView()
            }else{
                VStack{
//                    Button("添加仓库",action:{
//                        let newStore = Store(name: "亚洲1号仓库", description: "封装中心", address: "航头镇航川路18号")
//                        CloudKitHelper.saveStore(store: newStore){ result in
//                            switch result {
//                            case .success(let addedStore ):
//                                print(addedStore)
//                            case .failure:
//                                print("fail")
//                            }
//                        }
//                    })
                    if modelData.goods.isEmpty {
                        EmptyList()
                    }else{
                        List{
                            ForEach(modelData.shelfs.keys.sorted(), id: \.self) { key in
                                Section(header: Text("货架：\(key)")){
                                    ForEach(modelData.shelfs[key] ?? []){ good in
                                        NavigationLink(
                                            destination: GoodDetail(good: good)){
                                            GoodRow(good: good)
                                        }
                                    }
                                }.textCase(nil)
                            }
                        }
                       
                    }
                    
                    
                } .navigationTitle("商品列表")
                .navigationBarItems(trailing: Button(action: {
                    self.showAddGood.toggle()
                }){
                    Text("添加商品")
                })
                


            }
        }.onAppear{
            //添加cloudkit订阅
            CloudKitHelper.addSubscripion()
            
            modelData.fetchStores(){ result in
                
            }
            
            modelData.fetchData(){ result in
                switch result{
                case .success:
                    self.loading = false
                case .failure(let err):
                    self.loading = false
                    print(err.localizedDescription)
                }
            }
        }
        .sheet(isPresented: $showAddGood, content: {
            AddGood(showAddGood:self.$showAddGood)
        })
    }
    
    
}

//struct GoodList_Preview : PreviewProvider{
//    static var previews: some View{
//        GoodList()
//            .environmentObject(ModelData())
//    }
//}

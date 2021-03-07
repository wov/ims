//
//  GoodList.swift
//  IMS
//
//  Created by wov on 2021/2/12.
//

import SwiftUI

struct GoodList : View {
    @EnvironmentObject var modelData: ModelData
    @State private var showOTSOnly = false
    @State private var showAlert = false
    @State var currentGood: Good?
    
    
    var filteredGoods: [Good]{
        modelData.goods.filter{ good in
            (!showOTSOnly || good.ots)
        }
    }
    
    
    var body: some View{
        NavigationView{
            List{
                ForEach(modelData.categories.keys.sorted(), id: \.self) { key in
                    Section(header: Text(key)){
                        ForEach(modelData.categories[key] ?? []){ good in
                            NavigationLink(
                                destination: GoodDetail(good: good)){
                                GoodRow(good: good)
                                //                                .onTapGesture {
                                //                                    currentGood = good
                                //                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("商品列表")
            //            .actionSheet(item: $currentGood){ good in
            //                ActionSheet(title: Text("\(good.name)"),buttons: [
            //                    .default(Text("添加库存"),action:{
            //                        self.showAlert = true
            //                    }),
            //                    .default(Text("减少库存")),
            //                    .destructive(Text("删除商品")
            //                    ),
            //                    .cancel(Text("取消"))
            //                ])
            //            }.alert(isPresented: $showAlert){
            //                Alert(
            //                    title : Text("ok"),
            //                    message : Text("message")
            //                )
            //
            //            }
            
            
            //            .navigationSubTitle("测试")
            //            .toolbar{ EditButton() }
            
            
            
            //            List{
            //                Toggle(isOn: $showOTSOnly) {
            //                    Text("只显示库存预警商品")
            //                }
            //                Section(header:Text("打包用品")){
            //                    ForEach(filteredGoods){ good in
            //                        NavigationLink(
            //                            destination: GoodDetail()){
            //                            GoodRow(good: good)
            //                        }
            //                    }
            //                }
            //            }
            //            .navigationTitle("我的商品")
        }
    }
}

struct GoodList_Preview : PreviewProvider{
    static var previews: some View{
        GoodList()
            .environmentObject(ModelData())
    }
}

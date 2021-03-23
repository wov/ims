//
//  GoodList.swift
//  IMS
//
//  Created by wov on 2021/2/12.
//

import SwiftUI

struct GoodList : View {
    @EnvironmentObject var modelData: ModelData
    @State private var showAlert = false
        
    //    var filteredGoods: [Good]{
    //        modelData.goods.filter{ good in
    //            (!showOTSOnly || good.ots)
    //        }
    //    }
    
    

    var body: some View{
        NavigationView{
            List{
                ForEach(modelData.shelfs.keys.sorted(), id: \.self) { key in
                    Section(header: Text("货架：\(key)")){
                        ForEach(modelData.shelfs[key] ?? []){ good in
                            NavigationLink(
                                destination: GoodDetail(good: good)){
                                GoodRow(good: good)
                            }
                        }
                    }
                }
            }
            .navigationTitle("商品列表")
        }.onAppear{
            modelData.fetchData()
        }
    }
}

struct GoodList_Preview : PreviewProvider{
    static var previews: some View{
        GoodList()
            .environmentObject(ModelData())
    }
}

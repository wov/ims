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
    
    
//    var filteredGoods: [Good]{
//        modelData.goods.filter{ good in
//            (!showOTSOnly || good.ots)
//        }
//    }
//
    var body: some View{
        NavigationView{
            List{
                ForEach(modelData.categories.keys.sorted(), id: \.self) { key in
                    Section(header: Text(key)){
                        ForEach(modelData.categories[key] ?? []){ good in
                            NavigationLink(
                                destination: GoodDetail(good: good)){
                                GoodRow(good: good)
                            }
                        }
                    }
                }
            }
            .navigationTitle("商品列表")
        }.onAppear {
            CloudKitHelper.fetch{ result in
                switch result{
                case .success(let newGood):
                    self.modelData.goods.append(newGood)
                case .failure(let err):
                    print(err.localizedDescription)
                }
            }
        }
    }
}

struct GoodList_Preview : PreviewProvider{
    static var previews: some View{
        GoodList()
            .environmentObject(ModelData())
    }
}

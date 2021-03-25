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
    @State private var loading = true
    
    var body: some View{
        NavigationView{
            if self.loading{
                ProgressView()
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
                .navigationTitle("商品列表")
                
            }
            
        }.onAppear{
//            self.loading = true
            modelData.fetchData(){ result in
                switch result{
                case .success:
                    self.loading = false
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

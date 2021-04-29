//
//  StoreRow.swift
//  IMS
//
//  Created by wov on 2021/4/24.
//

import SwiftUI

struct StoreRow : View {
//    @EnvironmentObject var modelData: ModelData
//    @State private var showAlert = false
//    @State private var loading = true
//    @State private var showAddGood: Bool = false
    var store:Store
    
    var body: some View{
        HStack{
            HStack{
                VStack(alignment: .leading){
                    Text(store.name)
                        .font(.title2)
                        .foregroundColor(.primary)
                    Spacer()
                    Text(store.description)
                        .font(.body)
                        .foregroundColor(.secondary)
                }
                Spacer()
                Button("添加协作者",action:{
                    
                })
            }
        }.padding()
    }
    
    
}

struct StoreRow_Preview : PreviewProvider{
    static var store = Store( name: "亚洲1号仓库", description: "淘宝电商发货用", address: "航头镇")
    static var previews: some View{
        StoreRow(store: store).previewLayout(.fixed(width: 300, height: 70))
//            .environmentObject(ModelData())
    }
}

//
//  GoodDetail.swift
//  IMS
//
//  Created by wov on 2021/2/14.
//

import SwiftUI

struct GoodDetail: View {
    @EnvironmentObject var modelData: ModelData
    
    var good: Good
    @State private var stock: String = ""
    
    var goodIndex: Int {
        modelData.goods.firstIndex(where: {$0.id == good.id})!
    }
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                AsyncImage(url: URL(string: good.src)!,
                           placeholder: { Text("Loading ...") },
                           image: { Image(uiImage: $0).resizable() })
                    .frame(width: 100, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                HStack {
                    Text("库存信息")
                        .font(.title2)
                    Spacer()
                    Text("剩余库存\(String(format: "%.2f", good.stock))\(good.unit)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
//                .font(.subheadline)
//                .foregroundColor(.secondary)
                
                Divider()
                
                Form{
                    TextField("库存",value:$modelData.goods[goodIndex].stock,formatter: NumberFormatter())
                }
                
                Text("商品日志")
                    .font(.title2)
                Text("good.logs")
            }
            .padding()
            
            Spacer()
        }.navigationTitle(good.name)
    }
}

struct GoodDetail_Previews: PreviewProvider {
//    static var goods = ModelData().goods
    static let modelData = ModelData()

    static var previews: some View {
        GoodDetail(good: modelData.goods[0])
            .environmentObject(modelData)
//        GoodDetail(good: goods[0])
    }
}

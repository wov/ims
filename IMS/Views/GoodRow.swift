//
//  GoodRow.swift
//  IMS
//
//  Created by wov on 2021/2/12.
//
import SwiftUI

struct GoodRow:View {
    var good:Good
        
    var body: some View{
        HStack {
            VStack{
                HStack {
                    Text(good.name)
                        .font(.title2)
                        .foregroundColor(.primary)
                    Spacer()
                }
                HStack {
                    Text("库存：\(String(format: "%.2f", good.stock))\(good.unit)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Spacer()
                }
            }
            Spacer()
        }
    }
}

struct GoodRow_Previews : PreviewProvider{
    static var goods = ModelData().goods
    
    static var previews: some View{
        Group {
            GoodRow(good: goods[0])
            GoodRow(good: goods[1])
        }.previewLayout(.fixed(width: 300, height: 70))
    }
}

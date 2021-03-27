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
                Text(good.shelfPosition)
                    .font(.caption)
                    .padding(5)
                    .frame(width: 40.0, height: 20.0)
                    .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.gray/*@END_MENU_TOKEN@*/)
                Spacer()
            }
            VStack{
                HStack {
                    VStack(alignment: .leading) {
                        HStack {
                            Text(good.name)
                                .font(.title2)
                                .foregroundColor(.primary)
                            
                        }
                        Text(good.code)
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                }
                HStack {
                    Text("库存：\(String(good.stock.clean))\(good.unit)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Spacer()
                }
            }
            if good.OTS {
                           Image(systemName: "exclamationmark.triangle.fill")
                               .foregroundColor(.red)
                       }
            
            
            
        }
    }
}

struct GoodRow_Previews : PreviewProvider{
    static var good = Good(name: "迷你夜灯", description: "", unit: "个", stock: 10, shelfNumber: "A1", shelfPosition: "101", code: "MTYD", minimumStock: 20, days2Sell: 20,OTS:true)
    
    
    static var goods = ModelData().goods
    
    static var previews: some View{
        GoodRow(good: good).previewLayout(.fixed(width: 300, height: 70))
        
//        Group {
//            GoodRow(good: goods[0])
//            GoodRow(good: goods[1])
//        }.previewLayout(.fixed(width: 300, height: 70))
    }
}

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
        modelData.goods.firstIndex(where: {$0.recordID == good.recordID})!
    }
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text(good.description)
                    .font(.body)
                Divider()
                
                
                List{
                    Section(header: Text("库存信息")){
                        HStack{
                            Text("当前库存")
                            Spacer()
                            Text("\(String(good.stock.clean))\(good.unit)")
                        }
                        
                        HStack{
                            Text("已采购库存")
                            Spacer()
                            Text("xxx")
                        }
                        
                        
                    }
                    
                    Button("删除", action: {
                        self.delGood(good:good)
                    })
                }
            }
            .padding()
            
            Spacer()
        }.navigationTitle(good.name)
    }
    
    func delGood(good:Good){
        CloudKitHelper.delete(recordID: good.recordID! , completion: {_ in 
            
        })
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

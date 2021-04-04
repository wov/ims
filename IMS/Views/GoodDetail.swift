//
//  GoodDetail.swift
//  IMS
//
//  Created by wov on 2021/2/14.
//

import SwiftUI

struct GoodDetail: View {
    @EnvironmentObject var modelData: ModelData
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var good: Good
    @State private var showStockOut: Bool = false
    @State private var showAlert: Bool = false
    
    var goodIndex: Int {
        modelData.goods.firstIndex(where: {$0.recordID == good.recordID})!
    }
    
    var body: some View {
        List {
            Section(header: Text("基本信息")){
                HStack{
                    Text("商品名称")
                    Spacer()
                    Text(good.name)
                }
                HStack{
                    Text("商品编码")
                    Spacer()
                    Text(good.code)
                }
                HStack{
                    Text(good.description)
                }
            }
            
            Section(header: Text("库存信息")){
                HStack{
                    Text("当前库存")
                    Spacer()
                    Text("\(String(good.stock.clean))\(good.unit)")
                }
                HStack{
                    Text("已采购库存")
                    Spacer()
                    Text("0\(good.unit)")
                }
                HStack{
                    Text("安全库存")
                    Spacer()
                    Text("\(good.minimumStock.clean)\(good.unit)")
                }
                
                Button("商品出库",action:{
                    self.showStockOut.toggle()
                })
                Button("加入到采购单",action:{
                    
                })
            }
            
            Section(header: Text("库位信息")){
                HStack{
                    Text("货架号")
                    Spacer()
                    Text(good.shelfNumber)
                }
                HStack{
                    Text("货位号")
                    Spacer()
                    Text(good.shelfPosition)
                }
            }
            
            Section(){
                Button("删除",action:{
                    self.showAlert = true
                }).alert(isPresented:$showAlert) {
                    Alert(
                        title: Text("删除商品"),
                        message: Text("确定删除该商品吗？"),
                        primaryButton: .destructive(Text("删除")) {
                            self.delGood(good: good)
                        },
                        secondaryButton: .cancel()
                    )
                }
            }
            
        }.navigationTitle(good.name)
        .listStyle(InsetGroupedListStyle())
        .sheet(isPresented: $showStockOut, content: {
            StockOut(good: good, showSheetView: self.$showStockOut)
        })
    }
    
    func delGood(good:Good){
        CloudKitHelper.delete(recordID: good.recordID! , completion: {result in
            switch result{
            case .success:
                modelData.remove(good: good)
                self.presentationMode.wrappedValue.dismiss()
            case .failure(let err):
                print(err)
                
                
            }
        })
    }
}

struct GoodDetail_Previews: PreviewProvider {
    //    static var goods = ModelData().goods
    static let modelData = ModelData()
    
    static var previews: some View {
        GoodDetail(good: modelData.goods[0])
            .environmentObject(modelData)
    }
}

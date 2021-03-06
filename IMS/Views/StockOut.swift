//
//  StockOut.swift
//  IMS
//
//  Created by wov on 2021/3/26.
//

import Foundation
import SwiftUI

//import SwiftUI

struct StockOut: View {
    //    @State private var draftProfile = Profile.default
    
    var good:Good
    @State private var outStockNumber: Float = 0
    @Binding var showSheetView: Bool

    var body: some View {
        
        let stockBinding = Binding<String>(get: {
            self.outStockNumber == 0 ?
                "":
                String(self.outStockNumber.clean)
        }, set: {
            self.outStockNumber = Float($0) ?? 0
        })
        
        NavigationView {
            VStack{
                Text(good.name)
                Text("出库数量")
                HStack{
                    TextField("填写出库数量",
                              text:stockBinding,
                              onCommit: {
                                self.saveChangeToCloudKit(good: good)
                              }
                    )
                    
                }.padding()
                Spacer()
            }.navigationBarItems(trailing: Button("保存", action: {
                self.saveChangeToCloudKit(good: good)
            }).disabled(outStockNumber == 0)
            )
            .navigationBarTitle(good.name, displayMode: .inline)
        }
    }
    
    func saveChangeToCloudKit(good:Good){
        //TODO: if there no value ,should warning the user.
        
        CloudKitHelper.changeStock(good: good, changeStock: -outStockNumber, completion: { result in
            switch result {
            case .success:
                self.showSheetView = false
                print("success")
            case .failure:
                print("fail")
            }
        })
        
    }
    
}

struct StockOut_Previews: PreviewProvider {
    
    
    static let tempgood:Good = Good(name: "短夜灯", description: "test", unit: "kg", stock: 100, shelfNumber: "A1", shelfPosition: "101", code: "MTYD", minimumStock: 20, days2Sell: 2)
    @State private var showSheetView: Bool = false

    

    static var previews: some View {
        StatefulPreviewWrapper(false) { StockOut(good: tempgood,showSheetView: $0) }
    }
}


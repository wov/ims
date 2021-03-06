//
//  AddGood.swift
//  IMS
//
//  Created by wov on 2021/2/14.
//

import SwiftUI
import CodeScanner
import CloudKit
import PhotosUI

//struct CaptureImageView {
//    @Binding var isShown: Bool
//    @Binding var image: Image?
//    @Binding var file: CKAsset?
//    func makeCoordinator() -> Coordinator {
//        return Coordinator(isShown: $isShown, image: $image , file: $file)
//    }
//}
//
//extension CaptureImageView: UIViewControllerRepresentable {
//    func makeUIViewController(context: UIViewControllerRepresentableContext<CaptureImageView>) -> UIImagePickerController {
//        let picker = UIImagePickerController()
//        picker.delegate = context.coordinator
//        picker.sourceType = .camera
//        return picker
//    }
//
//    func updateUIViewController(_ uiViewController: UIImagePickerController,
//                                context: UIViewControllerRepresentableContext<CaptureImageView>) {
//
//    }
//}


struct AddGood: View {
    @Binding var showAddGood: Bool
    @Binding var currentStore: Store
    
    @EnvironmentObject var modelData: ModelData
    @State private var newGood = Good( name: "", description: "", unit: "",  stock: 0 , shelfNumber:"",shelfPosition:"",code:"",minimumStock:0,days2Sell:0)
    
    @State private var showingAlert = false
    @State private var showSuccessStoreAlert = false
    
    var body: some View {
        
        let stockBinding = Binding<String>(get: {
            self.newGood.stock == 0 ?
                "":
                String(self.newGood.stock.clean)
        }, set: {
            self.newGood.stock = Float($0) ?? 0
        })
        
        let minimumStockBinding = Binding<String>(get: {
            self.newGood.minimumStock == 0 ?
                "":
                String(self.newGood.minimumStock.clean)
        }, set: {
            self.newGood.minimumStock = Float($0) ?? 0
        })
        
        let days2SellBinding = Binding<String>(get: {
            self.newGood.days2Sell == 0 ?
                "" :
                String(self.newGood.days2Sell)
        }, set: {
            self.newGood.days2Sell = Int($0) ?? 0
        })
        
        
        NavigationView{
            Form{
                Section(header: Text("基本信息")){
                    
                    HStack {
                        Text("商品名称")
                        TextField("商品名称",text:$newGood.name)
                    }
                    
                    HStack {
                        Text("商品编码")
                        TextField("商品编码",text:$newGood.code)
                    }
                    
                    HStack {
                        Text("计量单位")
                        TextField("如:kg,个",text:$newGood.unit)
                    }
                    
                    
                    HStack {
                        Text("商品描述")
                        TextField("商品描述",text:$newGood.description)
                    }
                }
                
                Section(header: Text("货架位置")){
                    
                    HStack {
                        Text("货架位置")
                        TextField("填写货架号",text:$newGood.shelfNumber)
                    }
                    
                    HStack {
                        Text("库位位置")
                        TextField("填写库位号",text:$newGood.shelfPosition)
                    }
                }
                
                Section(header: Text("库存预警设置")){
                    
                    HStack {
                        Text("初始库存")
                        
                        TextField("初始库存",
                                  text: stockBinding
                        )
                        .keyboardType(.decimalPad)
                        
                    }
                    
                    HStack {
                        Text("最低库存")
                        TextField("填最低库存数量",
                                  text:minimumStockBinding)
                            .keyboardType(.decimalPad)
                        
                    }
                    
                    HStack {
                        Text("周转天数")
                        TextField("周转天数",
                                  text:days2SellBinding)
                            .keyboardType(.decimalPad)
                        
                        
                        
                    }
                }
                
            }.navigationBarTitle("添加新商品", displayMode: .inline)
            .navigationBarItems(leading:
                                    Button(action: {
                                        self.showAddGood = false
                                    }, label: {
                                        Text("取消")
                                    }), trailing:
                                        Button(action: {
                                            CloudKitHelper.save(good:newGood,parentRecordID: currentStore.recordID!){ result in
                                                switch result {
                                                case .success(let addedGood):
                                                    modelData.addGood(good: addedGood)
                                                    self.newGood =  Good( name: "", description: "", unit: "",  stock: 0 , shelfNumber:"",shelfPosition:"",code:"",minimumStock:0,days2Sell:0)
                                                    self.showAddGood = false
                                                case .failure:
                                                    print("fail")
                                                }
                                            }
                                        }, label: {
                                            Text("保存")
                                        })
            )
        }
//        .alert(isPresented: $showSuccessStoreAlert) {
//            Alert(title: Text("保存成功"), message: Text("well done!"))
//        }
    }
    
}

//struct AddGoodDetail_Previews: PreviewProvider {
//    
//    
//    static let tempgood:Good = Good(name: "短夜灯", description: "test", unit: "kg", stock: 100, shelfNumber: "A1", shelfPosition: "101", code: "MTYD", minimumStock: 20, days2Sell: 2)
//    @State private var showSheetView: Bool = false
//
//
//    static var previews: some View {
//        StatefulPreviewWrapper(false) { AddGood(showAddGood: $0) }
//    }
//}

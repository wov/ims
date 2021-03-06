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
                Section(header: Text("????????????")){
                    
                    HStack {
                        Text("????????????")
                        TextField("????????????",text:$newGood.name)
                    }
                    
                    HStack {
                        Text("????????????")
                        TextField("????????????",text:$newGood.code)
                    }
                    
                    HStack {
                        Text("????????????")
                        TextField("???:kg,???",text:$newGood.unit)
                    }
                    
                    
                    HStack {
                        Text("????????????")
                        TextField("????????????",text:$newGood.description)
                    }
                }
                
                Section(header: Text("????????????")){
                    
                    HStack {
                        Text("????????????")
                        TextField("???????????????",text:$newGood.shelfNumber)
                    }
                    
                    HStack {
                        Text("????????????")
                        TextField("???????????????",text:$newGood.shelfPosition)
                    }
                }
                
                Section(header: Text("??????????????????")){
                    
                    HStack {
                        Text("????????????")
                        
                        TextField("????????????",
                                  text: stockBinding
                        )
                        .keyboardType(.decimalPad)
                        
                    }
                    
                    HStack {
                        Text("????????????")
                        TextField("?????????????????????",
                                  text:minimumStockBinding)
                            .keyboardType(.decimalPad)
                        
                    }
                    
                    HStack {
                        Text("????????????")
                        TextField("????????????",
                                  text:days2SellBinding)
                            .keyboardType(.decimalPad)
                        
                        
                        
                    }
                }
                
            }.navigationBarTitle("???????????????", displayMode: .inline)
            .navigationBarItems(leading:
                                    Button(action: {
                                        self.showAddGood = false
                                    }, label: {
                                        Text("??????")
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
                                            Text("??????")
                                        })
            )
        }
//        .alert(isPresented: $showSuccessStoreAlert) {
//            Alert(title: Text("????????????"), message: Text("well done!"))
//        }
    }
    
}

//struct AddGoodDetail_Previews: PreviewProvider {
//    
//    
//    static let tempgood:Good = Good(name: "?????????", description: "test", unit: "kg", stock: 100, shelfNumber: "A1", shelfPosition: "101", code: "MTYD", minimumStock: 20, days2Sell: 2)
//    @State private var showSheetView: Bool = false
//
//
//    static var previews: some View {
//        StatefulPreviewWrapper(false) { AddGood(showAddGood: $0) }
//    }
//}

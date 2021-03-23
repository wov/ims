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

struct CaptureImageView {
    @Binding var isShown: Bool
    @Binding var image: Image?
    @Binding var file: CKAsset?
    func makeCoordinator() -> Coordinator {
        return Coordinator(isShown: $isShown, image: $image , file: $file)
    }
}

extension CaptureImageView: UIViewControllerRepresentable {
    func makeUIViewController(context: UIViewControllerRepresentableContext<CaptureImageView>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .camera
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController,
                                context: UIViewControllerRepresentableContext<CaptureImageView>) {
        
    }
}


struct AddGood: View {
    
    @EnvironmentObject var modelData: ModelData
    @State private var newGood = Good( name: "", description: "", unit: "",  stock: 0 , category: "", shelfNumber:"",shelfPosition:"")
    
    @State private var showingAlert = false
    @State private var isShowingScanner = false
    
    @State var image: Image? = nil
    @State var showCaptureImageView: Bool = false
    @State var uiimage: UIImage? = nil
    @State var file: CKAsset? = nil
    
    @State private var showSuccessStoreAlert = false
    
    
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("基本信息")){
                    TextField("商品名称",text:$newGood.name)
                    TextField("单位，如：kg、个",text:$newGood.unit)
                    TextField("产品分类",text:$newGood.category)
                    TextField("商品描述",text:$newGood.description)
                }
                
                Section(header: Text("货架位置")){
                    TextField("货架号",text:$newGood.shelfNumber)
                    TextField("库位号",text:$newGood.shelfPosition)
                }

            }.navigationBarTitle("添加新商品")
            .navigationBarItems(trailing:
                                    Button(action: {
                                        CloudKitHelper.save(good:newGood){ result in
                                            switch result {
                                            case .success:
                                                self.showSuccessStoreAlert = true
                                            case .failure:
                                                print("fail")
                                            }
                                        }
                                        
                                        self.newGood = Good( name: "", description: "", unit: "", stock:0 ,category: "" ,shelfNumber: "", shelfPosition: "")
                                        
                                    }, label: {
                                        Text("保存")
                                    })
            )
        }.alert(isPresented: $showSuccessStoreAlert) {
            Alert(title: Text("保存成功"), message: Text("well done!"))
        }
    }
    
//    func handleScan(result: Result<String,CodeScannerView.ScanError>){
//        self.isShowingScanner = false
//        
//        switch result {
//        case .success(let code):
//            self.newGood.barCode = code
//        case .failure:
//            print("Scanning failed")
//        }
//    }
    //
    //    func save(good: Good){
    //        let record = CKRecord(recordType: "goods")
    //
    //        record.setValuesForKeys([
    //            "barcode": good.barCode,
    //            "name": good.name,
    //            "unit": good.unit,
    //            "category": good.category,
    //            "location": good.location,
    //            "description": good.description
    //        ])
    //
    //        record.setObject(self.file, forKey: "photo")
    //
    //        let container = CKContainer.default()
    //        let database = container.privateCloudDatabase
    //
    //        database.save(record) { record, error in
    //            if let error = error {
    //                // Handle error.
    //                print(error)
    //                return
    //            }
    //
    //            self.showSuccessStoreAlert = true
    //
    //            self.newGood = Good( name: "", description: "", unit: "", supplier: "", stock:nil , ots: false, barCode: "",category: "",location:"")
    //
    //        }
    //    }
    //
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
}

struct AddGoodDetail_Previews: PreviewProvider {
    //    static let modelData = ModelData()
    static var previews: some View {
        AddGood()
    }
}

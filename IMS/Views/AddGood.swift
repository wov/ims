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
    @State private var newGood = Good( name: "", description: "", unit: "",  stock: 0 , shelfNumber:"",shelfPosition:"",code:"",minimumStock:0,days2Sell:0)
    
    @State private var showingAlert = false
    @State private var showSuccessStoreAlert = false
    
    
    var body: some View {
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
                        Text("初始库存量")
                        TextField("初始库存", value: $newGood.stock, formatter: NumberFormatter())
                    }
                    
                    HStack {
                        Text("最低库存量")
                        TextField("填最低库存数量", value: $newGood.minimumStock, formatter: NumberFormatter())
//                        TextField("",text:$newGood.minimumStock)
                    }
                    
                    HStack {
                        Text("可销售天数")
                        TextField("按最近出库量", value: $newGood.days2Sell, formatter: NumberFormatter())
                    }
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
                                        
                                        self.newGood =  Good( name: "", description: "", unit: "",  stock: 0 , shelfNumber:"",shelfPosition:"",code:"",minimumStock:0,days2Sell:0)
                                        
                                    }, label: {
                                        Text("保存")
                                    })
            )
        }.alert(isPresented: $showSuccessStoreAlert) {
            Alert(title: Text("保存成功"), message: Text("well done!"))
        }
    }
    

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

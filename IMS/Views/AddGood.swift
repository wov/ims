//
//  AddGood.swift
//  IMS
//
//  Created by wov on 2021/2/14.
//

import SwiftUI
import CodeScanner

struct AddGood: View {
    
    @EnvironmentObject var modelData: ModelData
    @State private var newGood = Good(id: 100100, name: "", description: "", unit: "", supplier: "", stock: 0.0, ots: false, src: "", price: "", barCode: "",category: .package)
    
    @State private var showingAlert = false
    @State private var isShowingScanner = false
    
    
    var body: some View {
        NavigationView{
            Form{
                HStack {
                    TextField("商品条码",text:$newGood.barCode)
                    Button(action: {
                        self.isShowingScanner = true
                    }) {
                        Image(systemName: "barcode.viewfinder")
                    }.sheet(isPresented: $isShowingScanner, content: {
                        CodeScannerView(codeTypes: [.ean8,.ean13,.upce], completion: self.handleScan)
                    })
                        
                }
                TextField("商品名称",text:$newGood.name)
                TextField("产品图片",text:$newGood.src)
                TextField("商品进价",text:$newGood.price)
                HStack {
                    Text("初始库存")
                    TextField("库存", text: Binding(
                        get: {String(self.newGood.stock)},
                        set: {v in self.newGood.stock = Float(v) ?? 0}
                    ))
                    .keyboardType(/*@START_MENU_TOKEN@*/.numbersAndPunctuation/*@END_MENU_TOKEN@*/)
                }
                TextField("商品单位",text:$newGood.unit)
                
                HStack(alignment: .top) {
                    Text("添加描述")
                    TextEditor(text: $newGood.description)
                        .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                }
                    
                
            }.navigationBarTitle("添加商品")
            .navigationBarItems(trailing:
                                    Button(action: {
                                        self.save(good: newGood)
                                    }, label: {
                                        Text("保存")
                                    })
            )
        }
    }
    
    func handleScan(result: Result<String,CodeScannerView.ScanError>){
        self.isShowingScanner = false
        
        switch result {
        case .success(let code):
            self.newGood.barCode = code
//            let details = code.components(separatedBy: "\n")
//            guard details.count == 2 else { return }
//
//            let person = Prospect()
//            person.name = details[0]
//            person.emailAddress = details[1]
//
//            self.prospects.people.append(person)
        case .failure:
            print("Scanning failed")
        }
    }
    
    func save(good: Good){
        modelData.goods.append(good)
    }
}

struct AddGoodDetail_Previews: PreviewProvider {
//    static let modelData = ModelData()
    static var previews: some View {
        AddGood()
    }
}

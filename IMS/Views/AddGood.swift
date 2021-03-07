//
//  AddGood.swift
//  IMS
//
//  Created by wov on 2021/2/14.
//

import SwiftUI
import CodeScanner

struct AddGood: View {
    @State var barCode: String = ""
    @State var name: String = ""
    @State var photo: String = ""
    @State var price: String = ""
    @State var stock: Float = 0
    @State var unit: String = ""
    @State var description: String = ""
    @State private var showingAlert = false
    @State private var isShowingScanner = false

    
    
    var body: some View {
        NavigationView{
            Form{
                HStack {
                    TextField("商品条码",text:$barCode)
                    Button(action: {
                        self.isShowingScanner = true
                    }) {
                        Image(systemName: "barcode.viewfinder")
                    }.sheet(isPresented: $isShowingScanner, content: {
                        CodeScannerView(codeTypes: [.code39,.code93,.code128], completion: self.handleScan)
                    })
                        
                }
                TextField("商品名称",text:$name)
                TextField("产品图片",text:$photo)
                TextField("商品进价",text:$price)
                HStack {
                    Text("初始库存")
                    TextField("库存", text: Binding(
                        get: {String(stock)},
                        set: {v in stock = Float(v) ?? 0}
                    ))
                    .keyboardType(/*@START_MENU_TOKEN@*/.numbersAndPunctuation/*@END_MENU_TOKEN@*/)
                }
                TextField("商品单位",text:$unit)
                
                HStack(alignment: .top) {
                    Text("添加描述")
                    TextEditor(text: $description)
                        .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                }
                    
                
            }.navigationBarTitle("添加商品")
            .navigationBarItems(trailing:
                                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                        Text("保存")
                                    })
            )
        }
    }
    
    func handleScan(result: Result<String,CodeScannerView.ScanError>){
        self.isShowingScanner = false
        
        switch result {
        case .success(let code):
            self.barCode = code
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
}

struct AddGoodDetail_Previews: PreviewProvider {
    static var previews: some View {
        AddGood()
    }
}

//
//  Good.swift
//  IMS
//
//  Created by wov on 2021/2/12.
//

//import Foundation
import SwiftUI
import CloudKit


struct Good:Identifiable{
    var id = UUID()
    var recordID: CKRecord.ID?
    var name: String
    var description: String
    var unit: String
//    var supplier: String
    var stock: Float?
//    var ots: Bool //是否缺货
//    var barCode: String //条码
    var category: String //分类
    var location: String //库位
    
//    enum Category:String,CaseIterable,Codable {
//        case package = "包装"
//        case block = "颗粒"
//    }

    
//    private var imageName: String
//    var image: Image{
//        Image(imageName)
//    }
    
}

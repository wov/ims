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
    var stock: Float
//    var category: String //分类
    var shelfNumber: String //货架号
    var shelfPosition: String //货架位
    var code: String //商品编码
}

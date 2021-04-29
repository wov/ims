//
//  Good.swift
//  IMS
//
//  Created by wov on 2021/2/12.
//
import CloudKit

struct Good:Identifiable{
    var id = UUID()
    var recordID: CKRecord.ID?
    var name: String
    var description: String
    var unit: String
    var stock: Float

    var shelfNumber: String //货架号
    var shelfPosition: String //货架位
    var code: String //商品编码
    
    var minimumStock: Float //最低库存量
    var days2Sell: Int // 最近销量动态预警
    
    var OTS: Bool = false //out of stock 是否缺货
    
    
}

//
//  Good.swift
//  IMS
//
//  Created by wov on 2021/2/12.
//

import Foundation
import SwiftUI
//import PhotosUI

struct Good:Hashable,Codable,Identifiable {
    var id: Int
    var name: String
    var description: String
    var unit: String
    var supplier: String
    var stock: Float
    var ots: Bool //是否缺货
    var price: String
    var barCode: String //条码
//    var photo: PHAsset
    
    var category: Category
    
    enum Category:String,CaseIterable,Codable {
        case package = "包装"
        case block = "颗粒"
    }

    
//    private var imageName: String
//    var image: Image{
//        Image(imageName)
//    }
    
}

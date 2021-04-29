//
//  Store.swift
//  IMS
//
//  Created by wov on 2021/4/17.
//

import CloudKit

//仓库
struct Store:Identifiable {
    var id = UUID()
    var recordID: CKRecord.ID?
    var name: String = "" //仓库的名字
    var description: String = ""  //描述
    var address: String = "" //地址
}

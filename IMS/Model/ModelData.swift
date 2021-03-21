//
//  ModelData.swift
//  IMS
//
//  Created by wov on 2021/2/12.
//

import Foundation
import Combine
import CloudKit


final class ModelData: ObservableObject{
    
    //    static let database = CKRecord(recordType: "goods")
    @Published var goods :[Good] = [] //loadDataFromCloudkit()
    
//    CKConinter.default().fetch(){ goods, error in
//    if let error = error{
//    print(error)
//    }else{
//    goods = goods
//    }
//
//    }
    //    let record = CKRecord(recordType: "goods")
    
//    CKContainer.default("goods").fetch(){}
//    let record = CKRecord(recordType: "goods")
    
//    record.setValuesForKeys([
//        "barcode": good.barCode,
//        "name": good.name,
//        "unit": good.unit,
//        "category": good.category,
//        "location": good.location,
//        "description": good.description
//    ])
//
//
    
    
    var categories: [String: [Good]] {
        Dictionary(
            grouping: goods,
            by: { $0.category }
        )
    }
    
}

func loadDataFromCloudkit() -> [Good]{
    var returnGoods: [Good] = []

    let query = CKQuery(recordType: "goods", predicate: NSPredicate(value: true))
    
    CKContainer.default().privateCloudDatabase.perform(query,inZoneWith: nil){ records,error in
        records?.forEach({ record in
            var newGood = Good( name: "", description: "", unit: "", supplier: "", stock:nil , ots: false, barCode: "",category: "",location:"")
            if let name = record["name"] as? String{
                newGood.name = name
            }
            returnGoods.append(newGood)
        })
    }
    
    return returnGoods
    
}

func load<T:Decodable>(_ filename: String) -> T{
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else{
        fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    }catch{
        fatalError("Couldn't find \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch{
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

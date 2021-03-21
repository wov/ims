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
    @Published var goods :[Good] = []
    
//    self.loadDataFromCloudkit()
    
    var categories: [String: [Good]] {
        Dictionary(
            grouping: goods,
            by: { $0.category }
        )
    }
    
}

//func loadDataFromCloudkit()  {
////    var goods: [Good] = []
//    CloudKitHelper.fetch{ result in
//        switch result{
//        case .success(let newGood):
//            ModelData().goods.append(newGood)
//        case .failure(let err):
//            print(err.localizedDescription)
//        }
//    }
////    return goods
//}

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

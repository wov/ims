//
//  ModelData.swift
//  IMS
//
//  Created by wov on 2021/2/12.
//

import Foundation
import Combine
//import CloudKit


final class ModelData: ObservableObject{
    @Published var goods :[Good] = []
    
    func fetchData( completion: @escaping (Result<Good, Error>) -> ()) {
        CloudKitHelper.fetch{ result in
            switch result{
            case .success(let newGood):
                self.addGood(good: newGood)
                completion(.success(newGood))
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    var shelfs: [String: [Good]] {
        Dictionary(
            grouping: goods,
            by: { $0.shelfNumber }
        )
    }
    
    func addGood(good:Good) {
        if !self.goods.contains(where: { $0.recordID == good.recordID }) {
            self.goods.append(good)
        }
    }
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

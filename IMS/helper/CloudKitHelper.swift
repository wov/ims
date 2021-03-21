//
//  CloudKitHelper.swift
//  IMS
//
//  Created by wov on 2021/3/20.
//


import Foundation
import CloudKit
import SwiftUI


struct CloudKitHelper {
    
    // MARK: - record types
    struct RecordType {
        static let Goods = "goods"
    }
    
    // MARK: - errors
    enum CloudKitHelperError: Error {
        case recordFailure
        case recordIDFailure
        case castFailure
        case cursorFailure
    }
    
    // MARK: - saving to CloudKit
    static func save(good: Good, completion: @escaping (Result<Good, Error>) -> ()) {
        let goodRecord = CKRecord(recordType: RecordType.Goods)
        goodRecord["barCode"] = good.barCode as CKRecordValue
        goodRecord["category"] = good.category as CKRecordValue
        goodRecord["location"] = good.location as CKRecordValue
        goodRecord["name"] = good.name as CKRecordValue
        goodRecord["unit"] = good.unit as CKRecordValue
        goodRecord["description"] = good.description as CKRecordValue
        
        
    
    
        CKContainer.default().privateCloudDatabase.save(goodRecord) { (record, err) in
            DispatchQueue.main.async {
                if let err = err {
                    completion(.failure(err))
                    return
                }
                guard let record = record else {
                    completion(.failure(CloudKitHelperError.recordFailure))
                    return
                }
                let recordID = record.recordID
                guard let name = record["name"] as? String ,
                    let description = record["description"] as? String ,
                    let unit = record["unit"] as? String ,
                    let supplier = record["supplier"] as? String ,
                    let ots = record["ots"] as? Bool ,
                    let barCode = record["barCode"] as? String ,
                    let category = record["category"] as? String ,
                    let location = record["location"] as? String
                      else {
                    completion(.failure(CloudKitHelperError.castFailure))
                    return
                }
                let good = Good(recordID: recordID,name: name, description: description, unit: unit, supplier: supplier, ots: ots, barCode: barCode, category: category, location: location)
                completion(.success(good))
            }
        }
    }
    
    // MARK: - fetching from CloudKit
    static func fetch(completion: @escaping (Result<Good, Error>) -> ()) {
        let pred = NSPredicate(value: true)
//        let sort = NSSortDescriptor(key: "creationDate", ascending: false)
        let query = CKQuery(recordType: RecordType.Goods, predicate: pred)
//        query.sortDescriptors = [sort]

        let operation = CKQueryOperation(query: query)
        operation.desiredKeys = ["name","category","location","unit"]
        operation.resultsLimit = 50
        
        operation.recordFetchedBlock = { record in
            print(record)
            
            
            DispatchQueue.main.async {
                let recordID = record.recordID
                
                guard let name = record["name"] as? String ,
//                    let description = record["description"] as? String ,
                    let unit = record["unit"] as? String ,
//                    let supplier = record["supplier"] as? String ,
//                    let ots = record["ots"] as? Bool ,
//                    let barCode = record["barCode"] as? String ,
                    let category = record["category"] as? String ,
                    let location = record["location"] as? String
                      else {
                    return
                }

                let good = Good(recordID: recordID,name: name, description: "", unit: unit, supplier: "", ots: false, barCode: "", category: category, location: location)
                completion(.success(good))
            }
        }
        
        operation.queryCompletionBlock = { (/*cursor*/ _, err) in
            DispatchQueue.main.async {
                if let err = err {
                    completion(.failure(err))
                    return
                }
//                guard let cursor = cursor else {
//                    completion(.failure(CloudKitHelperError.cursorFailure))
//                    return
//                }
//                print("Cursor: \(String(describing: cursor))")
            }
            
        }
        
        CKContainer.default().privateCloudDatabase.add(operation)
    }
    
    // MARK: - delete from CloudKit
    static func delete(recordID: CKRecord.ID, completion: @escaping (Result<CKRecord.ID, Error>) -> ()) {
        CKContainer.default().publicCloudDatabase.delete(withRecordID: recordID) { (recordID, err) in
            DispatchQueue.main.async {
                if let err = err {
                    completion(.failure(err))
                    return
                }
                guard let recordID = recordID else {
                    completion(.failure(CloudKitHelperError.recordIDFailure))
                    return
                }
                completion(.success(recordID))
            }
        }
    }
    
    // MARK: - modify in CloudKit
    static func modify(item: Good, completion: @escaping (Result<Good, Error>) -> ()) {
        guard let recordID = item.recordID else { return }
        CKContainer.default().publicCloudDatabase.fetch(withRecordID: recordID) { record, err in
            if let err = err {
                DispatchQueue.main.async {
                    completion(.failure(err))
                }
                return
            }
            guard let record = record else {
                DispatchQueue.main.async {
                    completion(.failure(CloudKitHelperError.recordFailure))
                }
                return
            }
//            record["text"] = item.text as CKRecordValue
//            todo: 增加修改的值
            CKContainer.default().privateCloudDatabase.save(record) { (record, err) in
                DispatchQueue.main.async {
                    if let err = err {
                        completion(.failure(err))
                        return
                    }
                    guard let record = record else {
                        completion(.failure(CloudKitHelperError.recordFailure))
                        return
                    }
                    let recordID = record.recordID
                    guard let name = record["name"] as? String ,
                        let description = record["description"] as? String ,
                        let unit = record["unit"] as? String ,
                        let supplier = record["supplier"] as? String ,
                        let ots = record["ots"] as? Bool ,
                        let barCode = record["barCode"] as? String ,
                        let category = record["category"] as? String ,
                        let location = record["location"] as? String
                          else {
                        completion(.failure(CloudKitHelperError.castFailure))
                        return
                    }
                    let good = Good(recordID: recordID,name: name, description: description, unit: unit, supplier: supplier, ots: ots, barCode: barCode, category: category, location: location)
                    completion(.success(good))
                }
            }
        }
    }
}

//
//  CloudKitHelper.swift
//  IMS
//
//  Created by wov on 2021/3/20.
//


import Foundation
import CloudKit
import UIKit

struct CloudKitHelper {
    
    // MARK: - record types
    struct RecordType {
        static let Goods = "goods"
        static let inouts = "inouts"
    }
    
    // MARK: - errors
    enum CloudKitHelperError: Error {
        case recordFailure
        case recordIDFailure
        case castFailure
        case cursorFailure
    }
    
    static func addSubscripion(){
        //        let container =  CKContainer.default()
        //        let db = container.CloudDatabase
        //        db.fetchAllSubscriptions { (subscriptions, error) in
        //            print(subscriptions)
        //        }
    }
    
    // MARK: - saving to CloudKit
    static func save(good: Good, completion: @escaping (Result<Good, Error>) -> ()) {
//        let recordID = CKRecord.ID(zoneID: )
        let ckRecordZoneID = CKRecordZone(zoneName: "sharedZone")
        let ckRecordID = CKRecord.ID(zoneID: ckRecordZoneID.zoneID)
        
        let goodRecord = CKRecord(recordType: RecordType.Goods,recordID: ckRecordID)
        
        goodRecord["name"] = good.name as CKRecordValue
        goodRecord["code"] = good.code as CKRecordValue
        
        goodRecord["unit"] = good.unit as CKRecordValue
        goodRecord["description"] = good.description as CKRecordValue
        
        goodRecord["stock"] = NSNumber(value: good.stock) // good.stock as NSNumber
        
        goodRecord["shelfNumber"] = good.shelfNumber as CKRecordValue
        goodRecord["shelfPosition"] = good.shelfPosition as CKRecordValue
        
        goodRecord["minimumStock"] = NSNumber(value: good.minimumStock)
        goodRecord["days2Sell"] = NSNumber(value: good.days2Sell)
        
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
                      let code = record["code"] as? String ,
                      
                      let description = record["description"] as? String ,
                      let unit = record["unit"] as? String ,
                      
                      let stock = record["stock"] as? Float,
                      let shelfNumber = record["shelfNumber"] as? String,
                      let shelfPosition = record["shelfPosition"] as? String,
                      let minimumStock = record["minimumStock"] as? Float,
                      let days2Sell = record["days2Sell"] as? Int
                else {
                    completion(.failure(CloudKitHelperError.castFailure))
                    return
                }
                
                let good = Good(recordID: recordID,name: name, description: description, unit: unit,  stock: stock,  shelfNumber: shelfNumber, shelfPosition: shelfPosition,code:code, minimumStock:minimumStock ,days2Sell: days2Sell )
                completion(.success(good))
            }
        }
    }
    
    // MARK: - fetching from CloudKit
    static func fetch(completion: @escaping (Result<Good?, Error>) -> ()) {
        
        
        let pred = NSPredicate(value: true)
        //        let sort = NSSortDescriptor(key: "creationDate", ascending: false)
        let query = CKQuery(recordType: RecordType.Goods, predicate: pred)
        //        query.sortDescriptors = [sort]
        
        let operation = CKQueryOperation(query: query)
        operation.desiredKeys = ["name","unit","description","shelfNumber","shelfPosition","stock","code","minimumStock","days2Sell"]
        //        operation.resultsLimit = 50
        
        operation.recordFetchedBlock = { record in
            DispatchQueue.main.async {
                let recordID = record.recordID
                guard let name = record["name"] as? String ,
                      let code = record["code"] as? String ,
                      
                      let description = record["description"] as? String ,
                      let unit = record["unit"] as? String ,
                      
                      let stock = record["stock"] as? Float,
                      let shelfNumber = record["shelfNumber"] as? String,
                      let shelfPosition = record["shelfPosition"] as? String,
                      let minimumStock = record["minimumStock"] as? Float,
                      let days2Sell = record["days2Sell"] as? Int
                else {
                    completion(.failure(CloudKitHelperError.castFailure))
                    return
                }
                
                let OTS: Bool = stock >= minimumStock ? false : true
                
                let good = Good(recordID: recordID,name: name, description: description, unit: unit,  stock: stock,  shelfNumber: shelfNumber, shelfPosition: shelfPosition,code:code, minimumStock:minimumStock ,days2Sell: days2Sell , OTS: OTS )
                
                completion(.success(good))
            }
        }
        
        operation.queryCompletionBlock = { (/*cursor*/ _, err) in
            DispatchQueue.main.async {
                //                print("has query all the records")
                if let err = err {
                    completion(.failure(err))
                    return
                }
                completion(.success(nil))
            }
            
        }
        
        CKContainer.default().privateCloudDatabase.add(operation)
    }
    
    // MARK: - delete from CloudKit
    static func delete(recordID: CKRecord.ID, completion: @escaping (Result<CKRecord.ID, Error>) -> ()) {
        CKContainer.default().privateCloudDatabase.delete(withRecordID: recordID) { (recordID, err) in
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
    
    //分享数据库
    
//    static func shareStorage(){
//        let ckRecordZoneID = CKRecordZone(zoneName: "sharedZone")
//        let ckRecordID = CKRecord.ID(zoneID: ckRecordZoneID.zoneID)
//
//        let goodRecord = CKRecord(recordType: RecordType.Goods,recordID: ckRecordID)
//        let share = CKShare(rootRecord:goodRecord)
//        
//        share[CKShare.SystemFieldKey.title] = "share this record?" as CKRecordValue?
//        
//        let sharingController = UICloudSharingController
//            (preparationHandler: {(UICloudSharingController, handler:
//            @escaping (CKShare?, CKContainer?, Error?) -> Void) in
//            let modifyOp = CKModifyRecordsOperation(recordsToSave:
//                [employeeRecord, share], recordIDsToDelete: nil)
//            modifyOp.modifyRecordsCompletionBlock = { (record, recordID,
//                error) in
//                handler(share, CKContainer.default(), error)
//            }
//            CKContainer.default().privateCloudDatabase.add(modifyOp)
//        })
//        sharingController.availablePermissions = [.allowReadWrite,
//            .allowPrivate]
//        sharingController.delegate = self
//        self.present(sharingController, animated:true, completion:nil)
//    }
//    
    
    // 修改库存量
    static func changeStock(good:Good , changeStock: Float, completion:  @escaping (Result<Good, Error>) -> ()){
        guard let recordID = good.recordID else { return }
        CKContainer.default().privateCloudDatabase.fetch(withRecordID: recordID){ record,err in
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
            
            record["stock"] = NSNumber(value: good.stock + changeStock)
            
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
                    guard let name = record["name"] as? String ,
                          let code = record["code"] as? String ,
                          
                          let description = record["description"] as? String ,
                          let unit = record["unit"] as? String ,
                          
                          let stock = record["stock"] as? Float,
                          let shelfNumber = record["shelfNumber"] as? String,
                          let shelfPosition = record["shelfPosition"] as? String,
                          let minimumStock = record["minimumStock"] as? Float,
                          let days2Sell = record["days2Sell"] as? Int
                    else {
                        completion(.failure(CloudKitHelperError.castFailure))
                        return
                    }
                    
                    let good = Good(recordID: recordID,name: name, description: description, unit: unit,  stock: stock,  shelfNumber: shelfNumber, shelfPosition: shelfPosition,code:code, minimumStock:minimumStock ,days2Sell: days2Sell )
                    completion(.success(good))
                }
            }
        }
    }
    
}

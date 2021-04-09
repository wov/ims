//
////////
////////  CloudShareButton.swift
////////  IMS
////////
////////  Created by wov on 2021/4/6.
////////
//////
//
//import CloudKit
//import SwiftUI
//
//struct UIKitCloudKitSharingButton: UIViewRepresentable {
//    typealias UIViewType = UIButton
//
//    @ObservedObject  var toShare: ObjectToShare
//    @State  var share: CKShare?
//
//    func makeUIView(context: UIViewRepresentableContext<UIKitCloudKitSharingButton>) -> UIButton {
//        let button = UIButton()
//
//        button.setImage(UIImage(systemName: "person.crop.circle.badge.plus"), for: .normal)
//        button.addTarget(context.coordinator, action: #selector(context.coordinator.pressed(_:)), for: .touchUpInside)
//
//        context.coordinator.button = button
//        return button
//    }
//
//    func updateUIView(_ uiView: UIButton, context: UIViewRepresentableContext<UIKitCloudKitSharingButton>) {
//
//    }
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    class Coordinator: NSObject, UICloudSharingControllerDelegate {
//        var button: UIButton?
//
//        func cloudSharingController(_ csc: UICloudSharingController, failedToSaveShareWithError error: Error) {
//            //Handle some errors here.
//            print(error)
//        }
//
//        func itemTitle(for csc: UICloudSharingController) -> String? {
//            return nil //parent.toShare.name
//        }
//
//        var parent: UIKitCloudKitSharingButton
//
//        init(_ parent: UIKitCloudKitSharingButton) {
//            self.parent = parent
//        }
//
//        @objc func pressed(_ sender: UIButton) {
//            //Pre-Create the CKShare record here, and assign to parent.share...
//
//            let ckRecordZoneID = CKRecordZone(zoneName: "sharedZone")
//            let ckRecordID = CKRecord.ID(zoneID: ckRecordZoneID.zoneID)
//            let goodRecord = CKRecord(recordType: "goods",recordID: ckRecordID)
//            let share = CKShare(rootRecord:goodRecord)
//            let container = CKContainer.default()
//
//            let sharingController = UICloudSharingController(share: share, container: container)
//
//            sharingController.delegate = self
//            sharingController.availablePermissions = [.allowReadWrite]
//            
//            if let button = self.button {
//                sharingController.popoverPresentationController?.sourceView = button
//            }
//
//            UIApplication.shared.windows.first?.rootViewController?.present(sharingController, animated: true)
//        }
//    }
//}

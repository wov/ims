//
//  Coordinator.swift
//  IMS
//
//  Created by wov on 2021/3/13.
//

import SwiftUI

class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

  @Binding var isCoordinatorShown: Bool
  @Binding var imageInCoordinator: Image?

  init(isShown: Binding<Bool>, image: Binding<Image?>) {
    _isCoordinatorShown = isShown
    _imageInCoordinator = image
  }

  func imagePickerController(_ picker: UIImagePickerController,
                didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
     guard let unwrapImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
     imageInCoordinator = Image(uiImage: unwrapImage)
     isCoordinatorShown = false
  }

  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
     isCoordinatorShown = false
  }
}

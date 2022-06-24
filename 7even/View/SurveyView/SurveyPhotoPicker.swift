//
//  SurveyPhotoPicker.swift
//  7even
//
//  Created by Kevin  Dwi on 23/06/22.
//

import Foundation
import SwiftUI

struct SurveyPhotoPicker: UIViewControllerRepresentable{
    @Binding var avatarImage:UIImage
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.allowsEditing = true
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(photoPicker: self)
    }
    
    final class Coordinator: NSObject, UINavigationControllerDelegate,UIImagePickerControllerDelegate{
        
        let photoPicker : SurveyPhotoPicker
        
        init(photoPicker: SurveyPhotoPicker){
            self.photoPicker = photoPicker
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.editedImage]as?UIImage{
                guard let data = image.jpegData(compressionQuality: 0.1),
                      let compressedImage = UIImage(data: data)else{
                    return
                }
                photoPicker.avatarImage = compressedImage
            }else{
                
            }
            picker.dismiss(animated: true)
        }
    }
}

//
//  AlertControl.swift
//  7even
//
//  Created by Inez Amanda on 27/06/22.
//

import Foundation
import UIKit
import SwiftUI

struct AlertControl: UIViewControllerRepresentable {

    @Binding var textString: String
    @Binding var show: Bool
    @Binding var room: RoomViewModel
    @Binding var isActive: Bool

    var title: String
    var message: String

    func makeUIViewController(context: UIViewControllerRepresentableContext<AlertControl>) -> UIViewController {
        return UIViewController() // holder controller - required to present alert
    }

    func updateUIViewController(_ viewController: UIViewController, context: UIViewControllerRepresentableContext<AlertControl>) {
        guard context.coordinator.alert == nil else { return }
        if self.show {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            context.coordinator.alert = alert

            alert.addTextField { textField in
                textField.placeholder = "Enter room code"
                textField.text = self.textString            // << initial value if any
                textField.delegate = context.coordinator    // << use coordinator as delegate
            }
            alert.addAction(UIAlertAction(title: "Cancel", style: .destructive) { _ in
                // your action here
            })
            
            alert.addAction(UIAlertAction(title: "Join", style: .default) { _ in
                print("Here we go")
                if(textString == room.roomCode ) {
                    self.isActive = true
                    print("detail")
                } else {
                    self.isActive = false
                    print("ga")
                }
//                print(textString)
                print(room.roomCode)
            })

            DispatchQueue.main.async { // must be async !!
                viewController.present(alert, animated: true, completion: {
                    self.show = false  // hide holder after alert dismiss
                    context.coordinator.alert = nil
                })
            }
        }
    }

    func makeCoordinator() -> AlertControl.Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        var alert: UIAlertController?
        var control: AlertControl
        init(_ control: AlertControl) {
            self.control = control
        }

        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if let text = textField.text as NSString? {
                self.control.textString = text.replacingCharacters(in: range, with: string)
            } else {
                self.control.textString = ""
            }
            return true
        }
    }
}

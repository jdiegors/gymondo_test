//
//  Messages.swift
//  Gymondo
//
//  Created by Juan Diego Rodriguez Steller on 22/9/23.
//

import Foundation
import UIKit

class Messages {
    public static let shared = Messages()
    
    private init() {}
    
    func showAlert(title: String, message: String, completion: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in }
        let retryAction = UIAlertAction(title: "Retry", style: .default) { _ in
            completion()
        }
        alert.addAction(okAction)
        alert.addAction(retryAction)
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let viewController = windowScene.windows.first?.rootViewController {
            viewController.present(alert, animated: true, completion: nil)
        }
    }
}

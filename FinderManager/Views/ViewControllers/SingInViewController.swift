//
//  SingInViewController.swift
//  FinderManager
//
//  Created by Никита Коголенок on 24.10.21.
//

import LocalAuthentication
import UIKit

class SingInViewController: UIViewController {
    
    // MARK: - Outlet
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        
        view.addSubview(button)
        button.center = view.center
        button.setTitle("Authorize", for: .normal)
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
    }
    
    @objc private func tapButton() {
        let context = LAContext()
        var error: NSError? = nil
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            
            let reason = "Plese authoorize with touch id!"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self] succes, error in
                
                DispatchQueue.main.async {
                    guard succes, error == nil else {
                        let alertController = UIAlertController(title: "Failed to Authenticase", message: "Please try again!", preferredStyle: .alert)
                        
                        let dismiss = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
                        alertController.addAction(dismiss)
                        
                        self?.present(alertController, animated: true)

                        return }
                    
                    guard let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as? ViewController else { return }
                    viewController.modalPresentationStyle = .fullScreen
                    
                    let navigationController = UINavigationController(rootViewController: viewController)
                    navigationController.modalPresentationStyle = .fullScreen
                    
                    self?.present(navigationController, animated: true, completion: nil)
                }
                
            }
        }
        else {
            let alertController = UIAlertController(title: "Unavailable", message: "You cant use this feature", preferredStyle: .alert)
            
            let dismiss = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
            alertController.addAction(dismiss)
            
            present(alertController, animated: true)
        }
    }
}

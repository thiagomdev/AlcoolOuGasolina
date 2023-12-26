import UIKit

final class CustomAlert {
    private let view: UIViewController
    
    init(view: UIViewController) {
        self.view = view
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionButton = UIAlertAction(title: "OK", style: .default)
        alert.addAction(actionButton)
        view.present(alert, animated: true)
    }
}

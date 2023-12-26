import UIKit

extension UITextField {
    func addDoneButtonKeyboard() {
        let doneToolbar = UIToolbar(
            frame: CGRect(
                x: 0,
                y: 0,
                width: UIScreen.main.bounds.width,
                height: 44)
        )
        
        doneToolbar.barStyle = .black
        let flexSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        let done = UIBarButtonItem(
            title: "OK",
            style: .done,
            target: self,
            action: #selector(handleDoneButton)
        )
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        inputAccessoryView = doneToolbar
    }
    
    @objc
    private func handleDoneButton() {
        resignFirstResponder()
    }
    
    static func makeTextField(_ placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.textAlignment = .left
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        textField.keyboardType = .decimalPad
        textField.textColor = .darkGray
        textField.adjustsFontSizeToFitWidth = true
        textField.returnKeyType = .next
        textField.addDoneButtonKeyboard()
        return textField
    }
}

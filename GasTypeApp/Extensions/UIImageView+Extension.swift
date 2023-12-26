import UIKit

extension UIImageView {
    static func makeImageView(_ named: String) -> UIImageView {
        let backgroung = UIImageView()
        backgroung.image = UIImage(named: named)
        backgroung.contentMode = .scaleAspectFit
        return backgroung
    }
}

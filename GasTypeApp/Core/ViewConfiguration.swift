import Foundation

import Foundation

protocol ViewConfiguration: AnyObject {
    func buildViews()
    func setupPin()
    func configUI()
    func setup()
}

extension ViewConfiguration {
    func setup() {
        buildViews()
        setupPin()
        configUI()
    }
}

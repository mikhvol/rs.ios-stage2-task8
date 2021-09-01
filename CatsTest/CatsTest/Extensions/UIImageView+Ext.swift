import UIKit

extension UIImageView {
    func animate() {
        self.alpha = 0
        UIView.animate(withDuration: 5) {
            self.alpha = 1
        }
    }
}

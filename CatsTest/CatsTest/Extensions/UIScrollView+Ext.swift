import UIKit

extension UIScrollView {
    func resizeContentSize() {
        let subViews = self.subviews
        let subviewsAscendingByMaxY = subViews.sorted(by: { $0.frame.maxY < $1.frame.maxY })
        guard let maxY = subviewsAscendingByMaxY.last?.frame.maxY else { return }
        self.contentSize.height = maxY
    }
}

import UIKit

extension UIActivityIndicatorView {
    func updateActivityIndicator(requestStatus : RequestResult) {
        if requestStatus == .waiting {
            self.startAnimating()
        } else {
            self.stopAnimating()
        }
    }
}

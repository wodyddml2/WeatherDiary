import UIKit

extension UIView {
    func borderStyle() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10
    }
    
    func shadowStyle() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.7
        self.layer.shadowRadius = 15
        self.layer.shadowOffset = CGSize(width: 0, height: 10)
    }
}

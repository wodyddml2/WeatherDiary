import UIKit

protocol ReuseableProtocol {
    static var reuseableIdentifier: String { get }
}

extension ViewController: ReuseableProtocol {
    static var reuseableIdentifier: String {
        String(describing: self)
    }
}

extension UICollectionViewCell: ReuseableProtocol {
    static var reuseableIdentifier: String {
        String(describing: self)
    }
}

import UIKit

class MainPlusCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var plusBackgroundView: UIView!
    @IBOutlet weak var plusImageView: UIImageView!
    
    func setupUI() {
        plusBackgroundView.borderStyle()
        
        self.shadowStyle()
        
        plusImageView.tintColor = .black
        plusImageView.image = UIImage(systemName: "plus.square")
    }
}

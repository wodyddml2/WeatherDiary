import UIKit

class MainPlusCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var plusBackgroundView: UIView!
    @IBOutlet weak var plusImageView: UIImageView!
    
    func setupUI() {
        plusBackgroundView.layer.masksToBounds = true
        plusBackgroundView.layer.cornerRadius = 10
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.7
        self.layer.shadowRadius = 15
        self.layer.shadowOffset = CGSize(width: 0, height: 10)
        
        plusImageView.tintColor = .black
        plusImageView.image = UIImage(systemName: "plus.square")
    }
}

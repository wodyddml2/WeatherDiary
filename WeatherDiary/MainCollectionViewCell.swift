import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var mainBackgroundView: UIView!
    @IBOutlet weak var mainBackgroundImageView: UIImageView!
    
    @IBOutlet weak var mainDiaryDateLabel: UILabel!
    
    func setupUI() {
        mainBackgroundView.layer.masksToBounds = true
        mainBackgroundView.layer.cornerRadius = 10
        

        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.7
        self.layer.shadowRadius = 15
        self.layer.shadowOffset = CGSize(width: 0, height: 10)
    }
}

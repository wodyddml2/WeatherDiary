import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var mainBackgroundView: UIView!
    @IBOutlet weak var mainBackgroundImageView: UIImageView!
    
    @IBOutlet weak var mainDiaryDateLabel: UILabel!
    
    func setupUI() {
        mainBackgroundView.borderStyle()
        
        self.shadowStyle()
    }
}

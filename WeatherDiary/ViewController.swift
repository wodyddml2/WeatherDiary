import UIKit

import Kingfisher

class ViewController: UIViewController {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var diaryCollectionView: UICollectionView!
    
    @IBOutlet weak var diaryTitleLabel: UILabel!
    
    @IBOutlet weak var currentTimeBackgroundView: UIView!
    @IBOutlet weak var currentTimeLabel: UILabel!
    
    @IBOutlet weak var locationReloadButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        diaryCollectionView.delegate = self
        diaryCollectionView.dataSource = self
        
        setupUI()
        
        diaryCollectionView.collectionViewLayout = mainCollectionViewLayout()
    }
    
    func setupUI() {
        headerView.backgroundColor = .clear
        
        diaryTitleLabel.text = "Weather Diary"
        diaryTitleLabel.font = UIFont(name: "establishRoomNo703OTF", size: 24)
        
        currentTimeBackgroundView.layer.cornerRadius = 10
        currentTimeLabel.font = .boldSystemFont(ofSize: 17)
        
        diaryCollectionView.backgroundColor = .clear
        
        // iOS15 UIButton
        if #available(iOS 15.0, *) {
            locationReloadButton.configuration = .configurationButtonStyle()
        } else {
            locationReloadButton.tintColor = .darkGray
            locationReloadButton.setTitle("", for: .normal)
            locationReloadButton.setImage(UIImage(systemName: "location.circle.fill"), for: .normal)
        }
        
    }
    

    func mainCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 16
        let width = (UIScreen.main.bounds.width / 2) - (spacing * 2)
        
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: width, height: width / 1.1)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 16
        
        return layout
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.reuseableIdentifier, for: indexPath) as? MainCollectionViewCell else { return UICollectionViewCell() }
       
        cell.mainBackgroundImageView.kf.setImage(with: URL(string: "http://openweathermap.org/img/wn/10d@2x.png"))
        
        cell.setupUI()
        return cell
    }
 
}

@available (iOS 15.0, *)
extension UIButton.Configuration {
    static func configurationButtonStyle() -> UIButton.Configuration {
        var configuration = UIButton.Configuration.filled()
        configuration.title = ""
        configuration.image = UIImage(systemName: "location.circle.fill")
        configuration.baseForegroundColor = .black
        configuration.baseBackgroundColor = .clear
        return configuration
    }
}

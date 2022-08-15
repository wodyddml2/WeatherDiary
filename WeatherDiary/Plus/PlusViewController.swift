import UIKit

class PlusViewController: UIViewController {
    
    @IBOutlet weak var weatherIconBackgroundView: UIView!
    @IBOutlet weak var weatherIconImageView: UIImageView!
    
    @IBOutlet weak var pickerBackgroundView: UIView!
    @IBOutlet weak var pickerImageView: UIImageView!
    
    @IBOutlet weak var weatherInfoBackgroundView: UIView!
    @IBOutlet weak var weatherInfoLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    
    @IBOutlet weak var diaryTextBackgroundView: UIView!
    @IBOutlet weak var diaryTextView: UITextView!
    
    @IBOutlet weak var diarySaveButton: UIButton!
    
    
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
        
        navigationBarStyle()
        setupUI()
    }
    
    func setupUI() {
        weatherInfoBackgroundView.borderStyle()
        weatherInfoBackgroundView.backgroundColor = .clear
        weatherInfoLabel.font = .boldSystemFont(ofSize: 18)
        weatherInfoLabel.text = "온도: \(20)°C  습도: \(40)  풍속: \(3)m/s"
        
        pickerImageView.borderStyle()
        pickerBackgroundView.shadowStyle()
        pickerBackgroundView.backgroundColor = .clear
        
        weatherIconImageView.borderStyle()
        weatherIconBackgroundView.shadowStyle()
        weatherIconBackgroundView.backgroundColor = .clear
        
        diarySaveButton.setTitle("완료", for: .normal)
        diarySaveButton.tintColor = .black
        diarySaveButton.backgroundColor = .green
        diarySaveButton.borderStyle()
        
        diaryTextBackgroundView.borderStyle()
        diaryTextView.text = ""
    }
    
    func navigationBarStyle() {
        let formmater = DateFormatter()
        formmater.dateFormat = "yyyy년 MM월 dd일"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(leftButtonClicked))
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "square.grid.2x2"), style: .plain, target: self, action: #selector(galleryButtonClicked)),
            UIBarButtonItem(image: UIImage(systemName: "camera"), style: .plain, target: self, action: #selector(cameraButtonClicked))
        ]
        navigationItem.title = formmater.string(from: Date())
        navigationController?.navigationBar.tintColor = .black
    }
    
    
    @objc func cameraButtonClicked() {
        
    }
    @objc func galleryButtonClicked() {
        
    }
    @objc func leftButtonClicked() {
        dismiss(animated: true)
    }

}

extension PlusViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
}

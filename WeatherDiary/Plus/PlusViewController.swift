import UIKit
import PhotosUI

import Kingfisher

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
    
    var weatherInfo: WeatherInfo?
    var index = UserDefaults.standard.integer(forKey: "index")
    
    let picker = UIImagePickerController()
    
    var configuration = PHPickerConfiguration()
    
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
        weatherInfoLabel.text = "온도: \(weatherInfo?.temp ?? "0")°C  습도: \(weatherInfo?.humidity ?? 0)  풍속: \(weatherInfo?.windSpeed ?? "0")m/s"
        weatherDescriptionLabel.font = .boldSystemFont(ofSize: 15)
        weatherDescriptionLabel.text = weatherInfo?.description ?? ""
        
        pickerImageView.borderStyle()
        pickerImageView.contentMode = .scaleAspectFill
        pickerBackgroundView.shadowStyle()
        pickerBackgroundView.backgroundColor = .clear
        
        weatherIconImageView.kf.setImage(with: URL(string: "\(EndPoint.openWeatherIconURL)\(weatherInfo?.icon ?? "10n")@2x.png"))
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
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            print("no")
            return
        }
        picker.sourceType = .camera
        picker.allowsEditing = true
        
        present(picker, animated: true)
    }
    @objc func galleryButtonClicked() {
        configuration.selectionLimit = 0
        configuration.filter = .images
        
        let phPicker = PHPickerViewController(configuration: configuration)
        
        phPicker.delegate = self
        
        present(phPicker, animated: true)
    }
    @objc func leftButtonClicked() {
        dismiss(animated: true)
    }
    
    @IBAction func saveButtonClicked(_ sender: UIButton) {
       
//        UserDefaults.standard.set(weatherInfo, forKey: "weather\(index)")
//        UserDefaults.standard.set(diaryTextView.text, forKey: "text\(index)")
        UserDefaults.standard.set(index + 1, forKey: "index")
        dismiss(animated: true)
    }
    

}

extension PlusViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.pickerImageView.image = image
            dismiss(animated: true)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
}

extension PlusViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        
        let itemProvider = results.first?.itemProvider
        
        if let itemProvider = itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                DispatchQueue.main.async {
                    self.pickerImageView.image = image as? UIImage
                }
            }
        }
    }

}

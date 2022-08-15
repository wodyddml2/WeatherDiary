import UIKit
import CoreLocation

import Kingfisher

class ViewController: UIViewController {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var diaryCollectionView: UICollectionView!
    
    @IBOutlet weak var diaryTitleLabel: UILabel!
    
    @IBOutlet weak var currentTimeBackgroundView: UIView!
    @IBOutlet weak var currentTimeLabel: UILabel!
    
    @IBOutlet weak var locationReloadButton: UIButton!
    
    let locationManager = CLLocationManager()
    
    var weatherInfo: WeatherInfo?
   
    override func viewDidLoad() {
        super.viewDidLoad()
       
        diaryCollectionView.delegate = self
        diaryCollectionView.dataSource = self
        
        locationManager.delegate = self
        
        setupUI()
        
        diaryCollectionView.collectionViewLayout = mainCollectionViewLayout()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        currentTimeLabel.text = formatter.string(from: Date())
        
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(currentTimeAction), userInfo: nil, repeats: true)
    }
    
    @objc func currentTimeAction() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        currentTimeLabel.text = formatter.string(from: Date())
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
        guard let plusCell = collectionView.dequeueReusableCell(withReuseIdentifier: MainPlusCollectionViewCell.reuseableIdentifier, for: indexPath) as? MainPlusCollectionViewCell else { return UICollectionViewCell() }
        
        if indexPath.item == 0 {
            plusCell.setupUI()
            return plusCell
        } else {
            cell.mainBackgroundImageView.kf.setImage(with: URL(string: "http://openweathermap.org/img/wn/10d@2x.png"))
            
            cell.setupUI()
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 0 {
            let plusSB = UIStoryboard(name: "Plus", bundle: nil)
            guard let plusVC = plusSB.instantiateViewController(withIdentifier: PlusViewController.reuseableIdentifier) as? PlusViewController else { return }
            
            let plusNav = UINavigationController(rootViewController: plusVC)
            plusNav.modalPresentationStyle = .fullScreen
            
            present(plusNav, animated: true)
        }
    }
 
}


extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = locations.last?.coordinate {
            RequestAPIManager.shared.requestOpenWeather(coordinate.latitude, coordinate.longitude) { weather in
                self.weatherInfo = weather
                DispatchQueue.main.async {
                    self.diaryCollectionView.reloadData()
                }
            }
        }
        locationManager.stopUpdatingLocation()
    }
    // iOS 14이상
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkUserDeviceLocationAuthorization()
    }
    // 이하
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
    }
}

extension ViewController {
    func showRequestLocationServiceAlert() {
        let requestLocationServiceAlert = UIAlertController(title: "위치정보 이용", message: "위치 서비스를 사용할 수 없습니다. 기기의 '설정>개인정보 보호'에서 위치 서비스를 켜주세요.", preferredStyle: .alert)
        let goSetting = UIAlertAction(title: "설정으로 이동", style: .destructive) { _ in
          
            if let appSetting = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(appSetting)
            }
        }
        let cancel = UIAlertAction(title: "취소", style: .default)
        requestLocationServiceAlert.addAction(cancel)
        requestLocationServiceAlert.addAction(goSetting)
        
        present(requestLocationServiceAlert, animated: true, completion: nil)
      }
    
    func checkUserDeviceLocationAuthorization() {
        let authorization: CLAuthorizationStatus
        
        if #available(iOS 14.0, *) {
            authorization = locationManager.authorizationStatus
        } else {
            authorization = CLLocationManager.authorizationStatus()
        }
        
        if CLLocationManager.locationServicesEnabled() {
            checkUserCurrnetLoactionAuthorization(authorization)
        } else {
            print("위치 설정 켜주세요")
        }
    }
    
    func checkUserCurrnetLoactionAuthorization(_ authorization: CLAuthorizationStatus) {
        switch authorization {
        case .notDetermined:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            showRequestLocationServiceAlert()
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        default: print("default")
        }
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

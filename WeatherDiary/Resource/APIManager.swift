import UIKit

import Alamofire
import SwiftyJSON

class RequestAPIManager {
    static let shared = RequestAPIManager()
    
    private init() { }
    
    func requestOpenWeather(_ lat: Double,_ lon: Double, _ completionHandler: @escaping (WeatherInfo) -> ()) {
        let url = "\(EndPoint.openWeatherURL)lat=\(lat)&lon=\(lon)&appid=\(APIKey.openWeather)"
        
        AF.request(url, method: .get).validate(statusCode: 200...400).responseData(queue: .global()) { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let weatherInfo = WeatherInfo(
                    icon: json["weather"][0]["icon"].stringValue,
                    temp: (json["main"]["temp"].doubleValue - 273.15),
                    humidity: json["main"]["humidity"].intValue,
                    windSpeed: json["wind"]["speed"].doubleValue,
                    description: json["weather"][0]["description"].stringValue)
                
                completionHandler(weatherInfo)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

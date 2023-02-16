//
//  ViewController.swift
//  depremApi_HOORN
//
//  Created by Ali on 16.02.2023.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    let motionManager = CMMotionManager()

   

    override func viewDidLoad() {
        super.viewDidLoad()
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 0.1
            motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (data, error) in
                if let error = error {
                    print("Hata: \(error.localizedDescription)")
                    return
                }
                if let data = data {
                    let acceleration = sqrt(pow(data.acceleration.x, 2) + pow(data.acceleration.y, 2) + pow(data.acceleration.z, 2))
                    print("Sarsıntı büyüklüğü: \(acceleration)")
                    
                    let urlString = "http://192.168.1.173/api.php?buyukluk"
                    let url = URL(string: urlString)!
                    var request = URLRequest(url: url)
                    request.httpMethod = "POST"
                    request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
                    if(acceleration>3.0055281053957836){
                        let parameters: [String: Any] = ["buyukluk": acceleration]
                        let postData = parameters.map { (key, value) in
                            return "\(key)=\(value)"
                        }.joined(separator: "&")
                        request.httpBody = postData.data(using: .utf8)
                    }
                   

                    let task = URLSession.shared.dataTask(with: request) { data, response, error in
                        guard let data = data, error == nil else {
                            print("Hata: \(error?.localizedDescription ?? "Bilinmeyen bir hata oluştu.")")
                            return
                        }
                        
                        if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                            print("Hata: HTTP isteği başarısız oldu. Kod: \(httpStatus.statusCode)")
                        }
                        
                        let responseString = String(data: data, encoding: .utf8)
                        print("Sunucudan gelen yanıt: \(responseString ?? "Yanıt yok")")
                    }
                    task.resume()

                }
            }
        }
    }


}


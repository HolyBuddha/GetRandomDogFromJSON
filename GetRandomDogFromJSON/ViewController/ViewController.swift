//
//  ViewController.swift
//  GetRandomDogFromJSON
//
//  Created by Vladimir Izmaylov on 27.09.2021.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    let urlAddress = "https://random.dog/woof.json"
    var dataFromJSON = RandomDogImage(url: "https://random.dog/8b48bc81-16fd-4d1d-b593-1d671107ca5a.jpg")
    var count = 0
    
    @IBOutlet var dogsCount: UILabel!
    @IBOutlet var showImage: UIImageView!
    @IBOutlet var runImageButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        runImageButton.layer.cornerRadius = 10
        
        NetworkManager.shared.fetchImage(from: dataFromJSON.url) { data in
            switch data {
            case .success(let data):
                self.showImage.image = UIImage(data: data)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    @IBAction func runImageButtonPressed() {
        NetworkManager.shared.getDataFromServer(urlAddress) { result in
            switch result {
            case .success(let data):
                self.dataFromJSON = data
                print(data.url ?? "")
            case .failure(let error):
                print(error)
            }
        }
        
        NetworkManager.shared.fetchImage(from: dataFromJSON.url) { data in
            switch data {
            case .success(let data):
                self.showImage.image = UIImage(data: data)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        count += 1
        dogsCount.text = "\(count)"
        
    }
}

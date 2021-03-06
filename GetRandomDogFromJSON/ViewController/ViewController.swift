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
    var dataFromJSON = RandomDogImage(url: "")
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var showImage: UIImageView!
    @IBOutlet var runImageButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        runImageButton.layer.cornerRadius = 10
        
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
    }
    
    @IBAction func runImageButtonPressed() {
        self.activityIndicator.startAnimating()
        showImage.image = UIImage()
        getDataFromServer()
        fetchImage()
    }
    
    private func getDataFromServer () {
        NetworkManager.shared.getDataFromServer(urlAddress) { result in
            switch result {
            case .success(let data):
                self.dataFromJSON = data
                print(data.url ?? "")
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func fetchImage () {
        NetworkManager.shared.fetchImage(from: dataFromJSON.url) { data in
            switch data {
            case .success(let data):
                self.showImage.image = UIImage(data: data)
                self.activityIndicator.stopAnimating()
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

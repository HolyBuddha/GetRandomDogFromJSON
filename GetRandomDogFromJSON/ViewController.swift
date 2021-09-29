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
  
    
    @IBOutlet var showImage: UIImageView!
    @IBOutlet var runImageButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        runImageButton.layer.cornerRadius = 10
        fetchImage()
       
    }


    @IBAction func runImageButtonPressed() {
        fetchImage()
    }
    
    private func fetchImage() {
        
        AF.request(urlAddress)
            .responseJSON { dataResponse in
                print(dataResponse)
            }
    
//        guard let url = URL(string: urlAddress) else { return }
//
//        URLSession.shared.dataTask(with: url) { data, _, error in
//            guard let data = data else {
//                print(error?.localizedDescription ?? "No error description")
//                return
            

//            guard let image = UIImage(data: JSON) else { return }
    
//            DispatchQueue.main.async {
//                self.showImage.image = image
//            }
//        }.resume()
    }
}

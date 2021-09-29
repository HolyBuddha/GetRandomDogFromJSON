//
//  NetworkManager.swift
//  GetRandomDogFromJSON
//
//  Created by Vladimir Izmaylov on 29.09.2021.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchImage(from url: String?, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: url ?? "") else {
            completion(.failure(.invalidURL))
            return
        }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
    
    func getDataFromServer(_ urlAddress: String, completion: @escaping(Result<RandomDogImage, NetworkError>) -> Void) {
        
        AF.request(urlAddress)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    guard let dataFromJSON = value as? [String : Any] else { return }
                    let randomDog = RandomDogImage(url: dataFromJSON["url"] as? String)
                    completion(.success(randomDog))
                case .failure:
                    completion(.failure(.decodingError))
                }
            }
    }
    
}

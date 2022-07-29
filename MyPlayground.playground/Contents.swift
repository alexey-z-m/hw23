import UIKit
import PlaygroundSupport
import CryptoKit

func getData(urlRequest: String) {
    guard let url = URL(string: urlRequest) else { return }
    let configuration: URLSessionConfiguration = .default
    configuration.allowsCellularAccess = true
    configuration.waitsForConnectivity = true
    let session = URLSession(configuration: configuration)
    session.dataTask(with: url) { (data, response, error) in
        if error != nil {
            print(error?.localizedDescription ?? "")
        } else { print("ошибок нет") }
        if let response = response as? HTTPURLResponse, response.statusCode == 200 {
            print(response)
        }
        if let data = data {
            let dataAsString = String(data: data, encoding: .utf8)
            print(dataAsString ?? "nil")
        }
    }.resume()
}

func MD5(string: String) -> String {
    let digest = Insecure.MD5.hash(data: string.data(using: .utf8) ?? Data())
    return digest.map {
        String(format: "%02hhx", $0)
    }.joined()
}

let publikAPIKey = "a0a684568b19c5174e95b5d14f5c3caa"
let privateAPIKey = "4bd938fd97d1eb93edb93aad6304d87a531fbd4f"
let timeStamp = "123"
let toHash = timeStamp + privateAPIKey + publikAPIKey
let baseUrl = "https://gateway.marvel.com/v1/public/characters/1011010?ts=" + timeStamp
let url = baseUrl + "&apikey=" + publikAPIKey + "&hash=" + MD5(string: toHash)
getData(urlRequest: url)


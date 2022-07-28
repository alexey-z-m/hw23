import UIKit
import PlaygroundSupport

func getData(urlRequest: String) {
    let urlRequest = URL(string: urlRequest)
    
    let configuration: URLSessionConfiguration = .default
    configuration.allowsCellularAccess = true
    configuration.waitsForConnectivity = true
    configuration.timeoutIntervalForRequest = 30
    
    let session = URLSession(configuration: configuration)
    
    guard let url = urlRequest else { return }
    
    session.dataTask(with: url) { data, response, error in
        if error != nil {
            print(error?.localizedDescription ?? "eR")
        } else if let response = response as? HTTPURLResponse, response.statusCode == 200 {
            guard let data = data else { return }
            let dataAsString = String(data: data, encoding: .utf8)
            print(dataAsString ?? "...")
            print(response.statusCode)
        }
    }.resume()
}
getData(urlRequest: "https://cataas.com/cat/says/Mobile%20Dev%20Factoty%20student")


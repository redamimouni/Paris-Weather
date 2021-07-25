//
//  Utils.swift
//  ParisWeather
//
//  Created by reda.mimouni on 20/07/2021.
//

import UIKit

extension Int {
    
    func timeIntervalToDateFormat(dateFormat: String) -> String {
        let timeInterval = TimeInterval(self)
        let date = Date(timeIntervalSince1970: timeInterval)
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        return formatter.string(from: date)
    }
}

extension URLSession {
    func dataTask(with url: URLRequest,
                  cachedResponseOnError: Bool,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return dataTask(with: url) { (data, response, error) in
            if cachedResponseOnError,
                let error = error,
                let cachedResponse = self.configuration.urlCache?.cachedResponse(for: url) {

                completionHandler(cachedResponse.data, cachedResponse.response, error)
                return
            }
            completionHandler(data, response, error)
        }
    }
}

extension UIImageView {
    static func fetchImage(from urlString: String, completionHandler: @escaping (_ data: Data?) -> ()) {
        let session = URLSession.shared
        let url = URL(string: urlString)
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                completionHandler(nil)
            } else {
                completionHandler(data)
            }
        }
        dataTask.resume()
    }
}

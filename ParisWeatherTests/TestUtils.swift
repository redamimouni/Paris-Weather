//
//  TestUtils.swift
//  ParisWeatherTests
//
//  Created by reda.mimouni on 14/07/2021.
//

import Foundation

class TestUtils: NSObject {
    static func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        return nil
    }
}

enum TestUtilsException: Error {
    case cantReadFileError
}

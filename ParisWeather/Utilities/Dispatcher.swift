//
//  Dispatcher.swift
//  ParisWeather
//
//  Created by reda.mimouni on 20/07/2021.
//

import Foundation

protocol Dispatcher {
    func main (closure : @escaping () -> ())
    func async (closure : @escaping () -> ())
}

final class DefaultDispatcher : Dispatcher {
    func main(closure: @escaping () -> ()) {
        DispatchQueue.main.async {
            closure()
        }
    }
    
    func async(closure: @escaping () -> ()) {
        DispatchQueue.global(qos: .background).async {
            closure()
        }
    }
}

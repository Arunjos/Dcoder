//
//  Dynamic.swift
//  Dcoder
//
//  Created by Arun Jose on 23/03/19.
//  Copyright © 2019 Arun Jose. All rights reserved.
//

import Foundation

class Dynamic<T>{
    typealias Listener = (T) -> ()
    
    var listeners:[Listener] = []
    var value:T {
        didSet{
            listeners.forEach{
                $0(value)
            }
        }
    }
    
    init(_ value:T) {
        self.value = value
    }
    func bind(_ listener: @escaping Listener){
        self.listeners.append(listener)
    }
}

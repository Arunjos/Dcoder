//
//  Array+safe.swift
//  Dcoder
//
//  Created by Arun Jose on 23/03/19.
//  Copyright © 2019 Arun Jose. All rights reserved.
//

import Foundation

extension Array {
    public subscript(safe index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }
        
        return self[index]
    }
}

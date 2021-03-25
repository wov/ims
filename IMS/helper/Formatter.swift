//
//  Formatter.swift
//  IMS
//
//  Created by wov on 2021/3/25.
//

import Foundation

extension Float {
    var clean: String {
       return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}

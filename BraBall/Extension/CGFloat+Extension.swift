//
//  CGFloat+rounded.swift
//  BraBall
//

import Foundation

extension CGFloat {
    
    func roundedAfterThirdDecimalPlace() -> CGFloat {
        floor(self * 100) / 100
    }
}

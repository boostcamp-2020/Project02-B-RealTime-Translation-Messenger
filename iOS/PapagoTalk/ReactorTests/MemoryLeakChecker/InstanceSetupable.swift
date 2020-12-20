//
//  InstanceSetupable.swift
//
//
//  Created by 김종원 on 2020/12/10.
//

import Foundation

protocol InstanceSetupable {}

extension InstanceSetupable where Self: AnyObject {
    func setup(_ closure: (Self) -> Void) -> Self {
        closure(self)
        return self
    }
}

extension InstanceSetupable where Self: Any {
    func modified(_ closure: (inout Self) -> Void) -> Self {
        var mutable = self
        closure(&mutable)
        return mutable
    }
}

extension NSObject: InstanceSetupable {}
extension Array: InstanceSetupable {}
extension Dictionary: InstanceSetupable {}
extension Set: InstanceSetupable {}

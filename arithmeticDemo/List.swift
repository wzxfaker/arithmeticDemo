//
//  List.swift
//  arithmeticDemo
//
//  Created by admin on 6/21/17.
//  Copyright © 2017 gcg. All rights reserved.
//

import UIKit

enum ListEnum<Element>{
    case Empty;
    indirect case Item(value : Element,next : ListEnum);//indirect表示用于声明递归的enum，因为next是enum List类型
}

class List: NSObject {
    //用枚举创建链表
    
}

extension ListEnum {
    func insert(x : Element) -> ListEnum {
        return ListEnum.Item(value : x,next : self);
    }
    
    func description() {
        var t = self;
        while case let ListEnum.Item(value: value, next: next) = t {
            print(value);
            t = next;
        }
    }
    
    mutating func push(x : Element) {
        self = self.insert(x: x);
    }
    
    mutating func pop() -> Element? {
        switch self {
        case .Empty:
            return nil;
        case let .Item(x,next):
            self = next;
            return x;
        }
    }
}

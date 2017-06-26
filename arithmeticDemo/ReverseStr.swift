//
//  reverseStr.swift
//  arithmeticDemo
//
//  Created by admin on 6/20/17.
//  Copyright © 2017 gcg. All rights reserved.
//

import UIKit

class ReverseStr: NSObject {
    public func reverseStr(s : String?) -> String?{
        guard let s = s else {
            return nil;
        }
        var chars = Array(s.characters),start = 0;
        reverse(chars: &chars, start: start, end: chars.count-1);
        print("reverseStr类中\(chars)");
        for i in 0..<chars.count {
            if i == chars.count - 1 || chars[i+1] == " " {
                reverse(chars: &chars, start: start, end: i);
                start = i+2;
            }
        }
        return String(chars);
    }
    
    func reverse<T>(chars : inout [T],start : Int,end : Int) {
        var start = start,end = end;
        while start < end {
            swap(chars: &chars, p: start, q: end);
            start += 1;
            end -= 1;
        }
    }
    
    func swap<T>(chars : inout [T],p : Int,q : Int) {
        let temp = chars[p];
        chars[p] = chars[q];
        chars[q] = temp;
    }
    
    var tempStr = "wang ze xin shi ge hao ren";
}

//
//  Sort.swift
//  arithmeticDemo
//
//  Created by admin on 07/07/2017.
//  Copyright © 2017 gcg. All rights reserved.
//

import UIKit

//排序方法的时间复杂度和空间复杂度参见sort.png
class Sort: NSObject {
    //归并排序
    func mergeSort(array : [Int]) -> [Int] {
        var helper = Array(repeating:0, count : array.count);//创建一个所有元素为0的数组
        var array = array;
        mergeSort(&array, &helper, 0, array.count-1);
        return array;
    }
    
    func mergeSort(inout array : [Int],inout _ helper : [Int],_ low : Int,_ high : Int) {//闭包
        guard low > high else {
            return;
        }
        let middle = (high - low) / 2 + low;
        mergeSort(&array, &helper, low, high);
        
    }
    
    
    
    
}




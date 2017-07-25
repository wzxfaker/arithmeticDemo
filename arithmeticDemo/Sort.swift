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
    //归并排序：归并算法通常用递归实现，先把待排序区间[s,t]以中点二分，接着把左边子区间排序，再把右边子区间排序，最后把左区间和右区间用一次归并操作合并成有序的区间[s,t]
    func mergeSort(array : [Int]) -> [Int] {
        var helper = Array(repeating:0, count : array.count);//创建一个所有元素为0的数组
        var array = array;
        mergeSort1(&array, &helper, 0, array.count-1);
        return array;
    }
    
    func mergeSort1(_ array : inout [Int],_ helper : inout [Int],_ low : Int,_ high : Int) {//闭包
        guard low < high else {
            return;
        }
        let middle = (high - low) / 2 + low;
        mergeSort1(&array, &helper, low, middle);
        mergeSort1(&array, &helper, middle+1, high);
        merge(array: &array , helper: &helper, low, middle, high);
    }
    
    func merge(array : inout [Int],helper : inout [Int],_ low : Int,_ middle : Int,_ high : Int) {
        for i in low...high {
            helper[i] = array[i];
        }
        var helperLeft = low;
        var helperRight = middle+1;
        var current = low;
        while helperLeft <= middle && helperRight <= high {
            if helper[helperLeft] <= helper[helperRight] {
                array[current] = helper[helperLeft];
                helperLeft += 1;
            }else{
                array[current] = helper[helperRight];
                helperRight += 1;
            }
            current += 1;
        }
        guard middle - helperLeft >= 0 else {
            return;
        }
        for i in 0...middle-helperLeft {
            array[current+i] = helper[helperLeft+i];
        }
    }
    
}




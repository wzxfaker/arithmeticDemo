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


/*
 已知有很多会议，如果有这些会议时间有重叠，则将它们合并。
 比如有一个会议的时间为3点到5点，另一个会议时间为4点到6点，那么合并之后的会议时间为3点到6点
 解题思路：解决算法题目第一步永远是把具体问题抽象化。这里每一个会议我们已知开始时间和结束时间，就可以写一个类来定义它，然后题目说已知有很多会议，就是说我们已知有一个MeetingTime的数组、所以题目就转化为写一个函数，输入为一个MeetingTime的数组，输出为一个将原数组中所有重叠时间都处理过的新数组。
 */
public class meetingTime {
    public var start : Int;
    public var end : Int;
    public init(_ start : Int,_ end : Int) {
        self.start = start;
        self.end = end;
    }
}

func merge(meetingTimes : [meetingTime]) -> [meetingTime]{
    guard meetingTimes.count > 1 else {
        return meetingTimes;
    }
    //排序
    var meetingTimes = meetingTimes.sorted(){
        if $0.start != $1.start {
            return $0.start < $1.start;
        }else{
            return $0.end < $1.end;
        }
    }
    
    //新建结果数组
    var resultArr = [meetingTime]();
    resultArr.append(meetingTimes[0]);
    
    //遍历排序后的原数组，并与结果数组归并
    for i in 1...meetingTimes.count-1 {
        let last = resultArr[resultArr.count-1];
        let current = meetingTimes[i];
        if last.end < current.start {
            resultArr.append(current);
        }else{
            last.end = max(last.end, current.end);
        }
    }
    return resultArr;
}





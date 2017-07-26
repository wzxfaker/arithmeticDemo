//
//  Sort.swift
//  arithmeticDemo
//
//  Created by admin on 07/07/2017.
//  Copyright © 2017 gcg. All rights reserved.
//

import UIKit

/*
 🏀🏀🏀在其他语言比如Java中，其自带的sort函数是用归并排序实现的。而在Swift源代码中，sort函数采用的是一种内审算法(IntroSort)。它由堆排序、插入排序、快速排序三种算法构成，依据输入的深度相应选择最佳的算法来完成。
 */

//排序方法的时间复杂度和空间复杂度参见sort.png
class Sort: NSObject {
    //----------------------------------------------归并排序----------------------------------------------
    /*
    归并排序：归并算法通常用递归实现，先把待排序区间[s,t]以中点二分，接着把左边子区间排序，再把右边子区间排序，最后把左区间和右区间用一次归并操作合并成有序的区间[s,t]
     */
    
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
    
    
    //----------------------------------------------选择排序----------------------------------------------
    /*
     选择排序：将最值出现在起始端，每比较一趟，就从第i个元素开始比较相邻的元素
     第1趟：在n个数中找到最大数与第一个交换
     第2趟：在剩下n-1个数中找到最大数与第二个数交换
     n-2与第三个…………
     第n-1趟：最终可实现数据排序
     */
    func selectSort( arr : inout [Int]) -> [Int] {
        for i in 0..<arr.count  {
            for j in i..<arr.count {//j后边的都与下标为j的元素进行比较，j前边的都是排好序的序列
                if arr[i] > arr[j] {
                    let temp = arr[i];
                    arr[i] = arr[j];
                    arr[j] = temp;
                }
            }
        }
        return arr;
    }
    
    //----------------------------------------------冒泡排序----------------------------------------------
    /*
     冒泡排序：比较相邻元素，将最值排到最右边。每比一趟，比较次数就少一次，到length-i-1后边的就是拍好序的元素
     相邻元素两两比较，比较完一趟，最值出现在末尾
     第1趟：依次比较相邻两个数，不断交换、逐个推进，最值最后出现在第n个元素位置
     第2趟：依次比较相邻两个数，不断交换、逐个推进，最值最后出现在第n-1个元素位置
     ………………
     第n-1趟：最值最后出现在第2个位置
     */
    func bubbleSort(arr : inout [Int]) -> [Int] {
        for i in 0..<arr.count {
            for j in 0..<arr.count-i-1 {
                if arr[j] > arr[j+1] {
                    let temp = arr[j];
                    arr[j] = arr[j+1];
                    arr[j+1] = temp;
                }
            }
        }
        return arr;
    }
    
    
    //----------------------------------------------插入排序----------------------------------------------
    /*
     将n个元素的数列分为已有序和无序两个部分，每次处理就是将无序数列的第一个元素与有序数列的元素从后往前逐个进行比较，找出插入位置，将该元素插入到有序数列的合适位置中
     */
    func insertSort(arr : inout [Int]) -> [Int] {
        var j : Int,temp : Int;
        for i in 1..<arr.count {
            temp = arr[i];
            j = i-1;
            while j >= 0 && arr[j] > temp {
                arr[j+1] = arr[j];
                j -= 1;
            }
            if j != i-1 {
                arr[j+1] = temp;
            }
        }
        return arr;
    }
    
    
    //----------------------------------------------快速排序----------------------------------------------
    /*
     一般取数组中第一个数为key，然后i=0，j=arr.count-1,使j递减并与key进行比较，如果a[j]<key,则把a[j]赋值给a[i],然后从i递增与key进行比较，如果a[i]>key,则把a[i]赋值给a[j],i递增，j递减，知道i=j停止，第一次循环使key左边的数都比key小，右边的都比key大，然后递归调用即可
     */
    func quickSort(arr : inout [Int],left : Int,right : Int) {
        if left >= right {
            return;//跳出递归，排序全部结束
        }
        var i = left,j = right,key = arr[left];
        while i < j {
            while i < j && arr[j] >= key {
                j -= 1;
            }
            arr[i] = arr[j];
            
            while i < j && arr[i] <= key {
                i += 1;
            }
            arr[j] = arr[i];
        }
        arr[i] = key;
        quickSort(arr: &arr, left: left, right: i);
        quickSort(arr: &arr, left: i+1, right: right);
    }
    
    
    //----------------------------------------------堆排序----------------------------------------------
    /*
     待学习
     */
    
    
    //----------------------------------------------桶排序----------------------------------------------
    /*
     待学习
     */
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





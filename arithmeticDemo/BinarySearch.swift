//
//  BinarySearch.swift
//  arithmeticDemo
//
//  Created by admin on 27/07/2017.
//  Copyright © 2017 gcg. All rights reserved.
//

import UIKit

class BinarySearch: NSObject {
    /*
     第一，mid 定义在 while 循环外面，如果定义在里面，则每次循环都要重新给 mid 分配内存空间，造成不必要的浪费；定义在循环之外，每次循环只是重新赋值；
     第二，每次重新给 mid 赋值不能写成mid = (right + left) / 2。这种写法表面上看没有问题，但当数组的长度非常大、算法又已经搜索到了最右边部分的时候，那么right + left就会非常之大，造成溢出导致程序崩溃。所以解决问题的办法是写成 mid = (right - left) / 2 + left。
     */
    func binarySearch(_ arr : [Int],_ target : Int) -> Bool {
        var left = 0,mid = 0,right = arr.count-1;
        while left <= right {
            mid = (right-left)/2+left;
            if arr[mid] > target {
                right = mid-1;
            }else if arr[mid] < target {
                left = mid+1;
            }else{
                return true;
            }
        }
        return false;
    }
    
    
    //递归版本
    func binarySearchRecur(arr : [Int],target : Int) -> Bool {
        return bSearchRecur(arr: arr, target: target, left: 0, right: arr.count-1);
    }
    
    func bSearchRecur(arr : [Int],target : Int,left : Int,right : Int) -> Bool {
        guard left <= right else {
            return false;
        }
        let mid = (right-left)/2+left;
        if arr[mid] == target {
            return true;
        }else if arr[mid] > target {
            return bSearchRecur(arr: arr, target: target, left: left, right: mid-1);
        }else{
            return bSearchRecur(arr: arr, target: target, left: mid+1, right: right);
        }
    }
    
    
    
    
    //--------------------------------------------- 实战演练 ---------------------------------------------//
    /*
     有一个产品发布了n个版本。它遵循以下规律：假如某个版本崩溃了，后面的所有版本都会崩溃。
     举个例子：一个产品假如有5个版本，1，2，3版都是好的，但是第4版崩溃了，那么第5个版本（最新版本）一定也崩溃。第4版则被称为第一个崩溃的版本。
     现在已知一个产品有n个版本，而且有一个检测算法 func isBadVersion(version: Int) -> Bool 可以判断一个版本是否崩溃。假设这个产品的最新版本崩溃了，求第一个崩溃的版本。
     思路：分析这种题目，同样还是先抽象化。我们可以认为所有版本为一个数组[1, 2, 3, ..., n]，现在我们就是要在这个数组中检测出满足 isBadVersion(version) == true中version的最小值。
     */
    func findFirstBadVersion(version : Int) -> Int{
        //特殊情况
        guard version >= 1  else {
            return -1;
        }
        var left = 0,right = version,mid = 0;
        while left < right {
            mid = (right-left)/2+left;
            if isBadVersion(mid) {
                right = mid;
            }else{
                left = mid+1;
            }
        }
        return left;//right也一样
    }
    
    func isBadVersion(_ version : Int) -> Bool {//判断是否是正常版本,假代码
        return true;
    }
    
    
    
    /*
     一个有序数组可能在某个位置被旋转。给定一个目标值，查找并返回这个元素在数组中的位置，如果不存在，返回-1。假设数组中没有重复值。
     举个例子：[0, 1, 2, 4, 5, 6, 7]在4这个数字位置上被旋转后变为[4, 5, 6, 7, 0, 1, 2]。搜索4返回0。搜索8则返回-1。
     分两种情况：一、翻转位置特别靠前，左边的就是有序数列，arr[mid] > arr[left]
               二、翻转位置特别靠后，右边的就是有序数列，arr[mid] < arr[left]
     */
    func search(arr : [Int],target : Int) -> Int {
        var (left,mid,right) = (0,0,arr.count-1);
        while left < right {
            if arr[mid] == target {
                return mid;
            }
            if arr[mid] > target {//翻转位置比较靠前
                if target >= arr[left] && target < arr[mid] {
                    right = mid-1;
                }else{
                    left = mid+1;
                }
            }else{
                if target <= arr[right] && target > arr[mid] {
                    left = mid+1;
                }else{
                    right = mid-1;
                }
            }
        }
        return -1;
    }
    
}

//
//  ViewController.swift
//  arithmeticDemo
//
//  Created by admin on 6/19/17.
//  Copyright © 2017 gcg. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //交换两个数：即：1.声明函数时，在参数前面用inout修饰，函数内部实现改变外部参数，2.传入参数时(调用函数时)，在变量名字前面用&符号修饰表示，表明这个变量在参数内部是可以被改变的（可将改变传递到原始数据）3.可以使用泛型增加扩展性
        func swap<T>(chars :inout [T],p : Int,q : Int) -> [T]{
            let temp = chars[p];
            chars[p] = chars[q];
            chars[q] = temp;
            return chars;
        }
        var charsArr = ["a","b",3,"d"] as [Any];
        print(swap(chars: &charsArr, p: 1, q: 2));
        
        
        //原因是函数中所有的参数是常量（let），是不可以修改的。解决的方法是在函数中写上var x = x，之后就可以对 x 进行修改了
        func toZero(x : Int) -> Int{
            var x = x;//此处用var重新声明一下即可
            while x > 0 {
                x -= 1;
            }
            return x;
        }
        print(toZero(x: 3))
        
        //排序:1.nums.sort()默认升序排序 2.nums.sorted()默认升序排序，且不会改变原始数据 3.还可以按照自定义的逻辑进行排序timeIntervals.sort { $0.startTime < $1.startTime }，其中0和1指前一个后一个 4.
        
        let nums = [1,4,2,8,5,6];
        //nums.sort({})一般结合闭包使用
        print(nums,nums.sorted(by:>));
        
        let dict : [String : String] = [
            "A":"100",
            "D":"23",
            "C":"35",
            "B":"20"
        ];
        let keysArr = Array(dict.keys);
        print(keysArr.sorted(by:>));
        
        let str : String? = "test"
        if let u = str {
            print("符合条件\(u)");
        }else{
            print("不符合条件");
        }
        
        guard let v : String = str else {
            print("guard中不符合条件")
        }
        print("guard中符合条件\(v)");
        
        //判断一个数组中是否存在两个数之和为target
        func twoSum(nums:[Int],_ target : Int) -> Bool{
            var set = Set<Int>();
            for num in nums {
                if set.contains(target-num) {
                    return true;
                }
                set.insert(num);
            }
            return false;
        }
        
        //判断并给出两个数的序号
        func twoSumOrder(nums : [Int],_ target : Int) -> [Int]{
            var dict = [Int : Int]();
            for (i,num) in nums.enumerated() {
//                if let lastIndex = dict[target - num] {
//                    return [lastIndex,i];
//                }else{
//                    dict[num] = i;
//                }
                guard let lastIndex = dict[target - num] else {
                    dict[num] = i;
                    continue;
                }
                return [lastIndex,i];
            }
            fatalError("No valid output");
        }
        print(twoSum(nums: [1,2,3,4,5], 6));
        print(twoSumOrder(nums: [1,2,3,5,4], 7));

        var tempStr : String = "wangzexin";
        let len = tempStr.characters.count;
        print(tempStr.remove(at: tempStr.characters.startIndex));
        tempStr += "shigehaoren"
        
        //检测字符串是否有数字组成
        func isStrNum(str:String) -> Bool{
            return Int(str) != nil;
        }
        
        
        let originalStr : String = "The sky is blue"
        let wordArr : Array = originalStr.components(separatedBy: " ");
        var reverseStr = String();
        let reversedArr : Array = wordArr.reversed();
        reverseStr = reversedArr.joined(separator: " ");
        print("时间复杂度比较高\(reverseStr)");
        
        
        //转换字符串
        func reverseWord(s : String?) -> String?{
            guard let s = s else {
                return nil;
            }
            var chars = Array(s.characters),start = 0;
            print("第一次分割",chars);
            reverse(chars: &chars, 0, chars.count-1);
            print("第一次分割reverse之后",chars);
            for i in 0..<chars.count {
                if i == chars.count - 1 || chars[i+1] == " "  {
                    reverse(chars: &chars, start, i);
                    start = i + 2;
                }
            }
            return String(chars);
        }
        func reverse<T>(chars : inout [T],_ start : Int,_ end : Int){
            var start = start,end = end;
            while start < end {
                swap(chars: &chars, p: start, q: end);
                start += 1;
                end -= 1;
            }
        }
        print("别人的方法",reverseWord(s: originalStr));
        
        let tempReverse = "wang ze xin shi ge hao ren";
        let reverseStrTool : ReverseStr = ReverseStr.init();
        print(reverseStrTool.reverseStr(s: tempReverse))
        
        
//        l.pop();
//        l.description();
//        l.push(x: 8);
//        l.description();
        
        
        //栈和队列
        let stackTool = StackAndQueue.init();
        print(stackTool.simplifyPath(path: "/a/b/./../d/"));
        print(stackTool.simplifyPath(path: "/a/./b/../../c/"));
        
        let tempStack : Stack = Stack.init(arr : [1,2,3,4,5]);
        print("pop--\(tempStack.pop())");
        
        let tempQueue : Queue = Queue.init(arr : [1,2,3,4,5]);
        print("dequeue--\(tempQueue.dequeue())");
        
        
        
        //归并排序
        let arr = [13,2,5,26,10,8];
        let sortTool = Sort.init();
        let resultArr = sortTool.mergeSort(array: arr);
        print("归并排序--\(resultArr)");
        var arr1 = [13,2,5,26,10,8,1,9];
        print("选择排序--\(sortTool.selectSort(arr: &arr1))");
        var arr2 = [65,2,13,2,5,26,10,8,1,9,5,20,11];
        print("冒泡排序--\(sortTool.bubbleSort(arr: &arr2))");
        var arr3 = [13,7,3,24,15,1,23,35,30];
        print("插入排序--\(sortTool.insertSort(arr: &arr3))");
        var arr4 = [10,8,3,9,15,16,2,1,30];
        sortTool.quickSort(arr: &arr4, left: 0, right: arr4.count-1);
        print("快速排序--\(arr4)");
        
        //翻转链表
        let node1=ListNode(10);
        let node2=ListNode(20);
        node1.next=node2;
        let node3=ListNode(30);
        node2.next=node3;
        let node4 = ListNode(40);
        node3.next=node4;
        let node5 = ListNode(50);
        node4.next=node5;
        let listTool = List.init();
        let tempListNode = listTool.revertList(node1);
        print("链表翻转2--\(tempListNode?.val)->\(tempListNode?.next?.val)");
        let tempListNode3 = listTool.revertList3(tempListNode);
        print("链表翻转3--\(tempListNode3?.val)->\(tempListNode3?.next?.val)");
        
        //二分查找
        let bSearchTool = BinarySearch.init();
        let binaryArr = [1,2,3,4,5,6];
        let target = 7;
        print("二分查找--\(bSearchTool.binarySearch(binaryArr, target))");
        print("二分递归查找--\(bSearchTool.binarySearchRecur(arr: binaryArr, target: 6))");
        
        //斐波拉契数列
        func Fib() -> Int {
            var (prev,curr) = (0,1);
            for _ in 1..<10 {
                (curr,prev) = (curr+prev,curr);
            }
            return curr;
        }
        print("斐波拉契数列--\(Fib())");
}
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

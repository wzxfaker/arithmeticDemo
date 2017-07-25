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
//    let l = ListEnum<Int>.Empty.insert(x: 2).insert(x: 3).insert(x: 4).insert(x: 5);
//    l.description();
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

//✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨链表✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨
class ListNode {//结点
    var val : Int;
    var next : ListNode?
    init(_ val : Int) {
        self.val = val;
        self.next = nil;
    }
}

class ListX{//链表
    var head : ListNode?;
    var tail : ListNode?;
    
    //尾插法
    func appendToTail(_ val : Int) {
        if tail == nil {
            tail = ListNode.init(val);
            head = tail;
        }else{
            tail!.next = ListNode(val);
            tail = tail!.next;
        }
    }
    
    //头插法
    func appendToHead(_ val : Int) {
        if head == nil {
            head = ListNode(val);
            tail = head;
        }else{
            let temp = ListNode(val);
            temp.next = head;
            head = temp;
        }
    }
}

//一道算法题：给一个链表和一个值x，要求将链表中所有小于x的值放到左边，所有大于等于x的值放到右边。原链表的节点顺序不能变。
//例：1->5->3->2->4->2，给定x = 3。则我们要返回 1->2->2->3->5->4

//思路：我们只要采用尾插法，遍历链表，将小于x值的节点接入新的链表即可。代码如下：
func getLeftList(_ head : ListNode?,x : Int) -> ListNode?{
    let dummy = ListNode(0);
    var pre = dummy;
    var node = head;
    while node != nil {
        if  node!.val < x {
            pre.next = node;
            pre = node!;
        }
        node = node!.next;
    }
    return dummy.next;
}

//算法题全部代码
func partition(_ head : ListNode?,x : Int) -> ListNode?{
    let prevDummy = ListNode(0);
    var prev = prevDummy;
    let postDummy = ListNode(0);
    var post = postDummy;
    
    var node = head;
    //尾插法处理左边和右边
    while node != nil {
        if node!.val < x {
            prev.next = node;
            prev = node!;//此处node是optional类型，而prev不是optional类型，所以需要用!转换一下
        }else{
            post.next = node;
            post = node!;
        }
        node = node!.next;
    }
    //拼接左边和右边
    post.next = nil;//防止链表循环指向构成环
    prev.next = postDummy.next;//此处post和postDummy有什么区别
    return prevDummy.next;
}

//快行指针，可以用来判断一个链表中是否有环
func hasCycle(_ head : ListNode?) -> Bool{
    var slow = head;
    var fast = head;
    while fast != nil && fast!.next!.next != nil   {
        slow = slow!.next;
        fast = fast!.next!.next;
        if slow === fast {//==只能用来判断两个value是否相等
            return true;
        }
    }
    return false;
}

//算法：删除链表中倒数第n个节点。例：1->2->3->4->5，n = 2。返回1->2->3->5。
//注意：给定n的长度小于等于链表的长度。
func removeNthFromEnd(_ head : ListNode?,_ n : Int) -> ListNode?{
    let dummy = ListNode(0);
    dummy.next = head;
    var prev : ListNode? = dummy;
    var post : ListNode? = dummy;
    //设置后一个结点的起始位置
    for _ in 0..<n {
        if post == nil {
            break;
        }
        post = post!.next;
    }
    //同时移动两个结点
    while post != nil && post!.next != nil {
        prev = prev!.next;
        post = post!.next;
    }
    //删除结点
    prev!.next = prev!.next!.next;
    return dummy.next;
}


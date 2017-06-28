//
//  StackAndQueue.swift
//  arithmeticDemo
//
//  Created by admin on 26/06/2017.
//  Copyright © 2017 gcg. All rights reserved.
//

import UIKit

//栈是一头通，队列是两头通
class StackAndQueue: NSObject {
    /*
     Given an absolute path for a file (Unix-style), simplify it.
     For example,
     path = "/home/", => "/home"
     path = "/a/./b/../../c/", => "/c"
     1.  . 代表当前路径。比如 /a/. 实际上就是 /a，无论输入多少个 . 都返回当前目录
     2.  ..代表上一级目录。比如 /a/b/.. 实际上就是 /a，也就是说先进入a目录，再进入其下的b目录，再返回b目录的上一层，也就是a目录。
     */
    //路径中
    public func simplifyPath(path : String) -> String{
        //用数组来实现桟的功能
        var pathStack = [String]();
        let paths = path.components(separatedBy: "/");
        for path in paths {
            //对于"."我们直接跳过
            guard path != "." else {
                continue;
            }
            //对于".."我们执行pop操作
            if path == ".." {
                if pathStack.count > 0 {
                    pathStack.removeLast();
                }
            //注意空数组的特殊情况
            }else if path != " " {
                pathStack.append(path);
            }
        }
        //将桟中的数据转化为优化后的路径，swift中高阶函数reduce,filter,Map
        let res = pathStack.reduce(""){total,dir in "\(total)/\(dir)"};
        //空路径的结果是“/”
        return res.isEmpty ? "/" : res;
    }
}

//先进后出
public class Stack {
    ///是否为空
    public var isEmpty : Bool{return stack.isEmpty}
    ///桟的大小
    public var size : Int{return stack.count}
    ///桟顶元素
    public var peek : Any?{return stack.last}
    private var stack : [Any];
    
    public init(){
        stack = [Any]();
    }
    
    //加入一个新元素
    public func push(_ obj : Any){
        stack.append(obj);
    }

    //推出桟顶元素
    public func pop() -> Any?{
        if isEmpty {
            return nil;
        }else{
            return stack.removeLast();
        }
    }
}


//先进先出
public class Queue {
    ///是否为空
    public var isEmpty : Bool{return queue.isEmpty}
    ///队列大小
    public var size : Int{return queue.count}
    ///队列首元素
    public var peek : Any?{
        return queue.last;
    }

    private var queue : [Any]

    public init(){
        queue = [Any]();
    }
    
    public func enqueue(_ obj : Any){
        queue.append(obj);
    }

    public func dequeue() -> Any? {
        if queue.isEmpty {
            return nil;
        }else{
            return queue.removeFirst();
        }
    
    }
}

//用桟来实现队列
class MyQueue{
    var stackA : Stack;
    var stackB : Stack;
    
    var isEmpty : Bool {
        return stackA.isEmpty && stackB.isEmpty;
    }

    var peek : Any? {
        get {
            shift();
            return stackB.peek;
        }
    }
    
    var size : Int {
        get {
            return stackA.size + stackB.size;
        }
    }
    
    init() {
        stackA = Stack();
        stackB = Stack();
    }
    
    func enqueue(object : Any) {
        stackA.push(object);
    }
    
    func dequeue() -> Any? {
        shift();
        return stackB.pop();
    }
    
    fileprivate func shift() {
        if stackB.isEmpty {
            while !stackA.isEmpty {
                stackB.push(stackA.pop());
            }
        }
    
    }
}


//用队列实现桟
class MyStack {
    var queueA : Queue;
    var queueB : Queue;
    
    init() {
        queueA = Queue();
        queueB = Queue();
    }
    
    var isEmpty : Bool {
        return queueA.isEmpty && queueB.isEmpty;
    }
    
    var peek : Any? {
        get {
            shift();
            let peekObj = queueA.peek;
            queueB.enqueue(queueA.dequeue()!);
            swap();
            return peekObj;
        }
    }
    
    var size : Int {
        return queueA.size;
    }
    
    func push(object : Any) {
        queueA.enqueue(object);
    }
    
    func pop() -> Any? {
        shift();
        let popObject = queueA.dequeue();
        swap();
        return popObject;
    }
    
    private func shift() {
        while queueA.size != 1 {
            queueB.enqueue(queueA.dequeue()!);
        }
    }
    
    private func swap() {
        (queueA,queueB) = (queueB,queueA);
    }
}

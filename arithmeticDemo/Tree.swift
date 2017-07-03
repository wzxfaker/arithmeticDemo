//
//  Tree.swift
//  arithmeticDemo
//
//  Created by admin on 30/06/2017.
//  Copyright © 2017 gcg. All rights reserved.
//

import UIKit

/*
    节点的度：一个节点含有的子树的个数称为该节点的度
    叶节点或终端节点：度为0的节点称为叶节点
    树的度：一棵树中，最大的节点的度称为树的度
    节点的层次：从根开始定义起，根为第1层，根的子节点为第2层，以此类推
    树的高度或深度：树中节点的最大层次
 
    二叉树：每个节点最多含有两个子树的树称为二叉树
    完全二叉树：叶节点只能出现在最下层和次下层，并且最下边一层的节点都集中在该层最左边若干位置的二叉树
    满二叉树：一个二叉树，如果每一层的节点数都达到最大值，则这个二叉树就是满二叉树
    二叉查找树：它的特点就是左子树中节点的值都小于根节点的值，右子树中节点的值都大于根节点的值
 
    表示方法：(A(B(D,E),C(F)) )
 */

class Tree: NSObject {
//    var root : TreeNode;
    
    func isValidBST(root : TreeNode?) -> Bool {
        return helper(root,nil,nil);
    }
    
    //面试中，最常见的是二叉查找树，它是一种特殊的二叉树。它的特点就是左子树中节点的值都小于根节点的值，右子树中节点的值都大于根节点的值
    //给你一棵二叉树，怎么判断它是二叉查找树
    private func helper (_ node : TreeNode?,_ min : Int?,_ max : Int?) -> Bool {
        guard let node = node else {//判断不为空
            return true;
        }
        //所有右子节点都必须大于根节点
        if let min = min,node.val <= min {//向右遍历
            return false;
        }
        //所有左子节点都必须小于根节点
        if let max = max,node.val >= max {//向左遍历
            return false;
        }
        return helper(node.left, min, node.val) && helper(node.right, node.val, max);
    }
    
    
    //遍历树：前序，中序，后序
    //用桟实现前序遍历
    func preOrderTraversal(root : TreeNode?) -> [Int]{
        var res = [Int]();
        var stack = [TreeNode]();
        var node = root;
        while !stack.isEmpty || node != nil{
            if node != nil {
                res.append(node!.val);
                stack.append(node!);
                node = node!.left;
            }else{
                node = stack.removeLast().right;
            }
        }
        return res;
    }
    
    
    //层级遍历
    func levelOrder(root : TreeNode?) -> [[Int]] {
        var res = [[Int]]();
        //用数组来实现队列
        var queue = [TreeNode]();
        if let root = root {
            queue.append(root);
        }
        while queue.count > 0 {
            let size = queue.count;
            var level = [Int]();
            
            for _ in 0 ..< size {
                let node = queue.removeFirst();
                level.append(node.val);
                if let left = node.left {
                    queue.append(left);
                }
                if let right = node.right {
                    queue.append(right);
                }
            }
            res.append(level);
        }
        return res;
    }
    
}

//二叉树中每个节点最多有两个子节点，一般称为左子节点和右子节点，并且二叉树的子树有左右之分，其次序不能任意颠倒
public class TreeNode {
    public var val : Int;
    public var left : TreeNode?;
    public var right : TreeNode?;
    public init (_ val : Int) {
        self.val = val;
    }
}


//计算树的最大深度
func maxDepth(_ root : TreeNode?) -> Int {
    guard let root = root else {//可选绑定
        return 0;
    }
    return max(maxDepth(root.left), maxDepth(root.right))+1;
}




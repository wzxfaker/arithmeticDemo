//
//  Tree.swift
//  arithmeticDemo
//
//  Created by admin on 30/06/2017.
//  Copyright © 2017 gcg. All rights reserved.
//

import UIKit

class Tree: NSObject {
    func isValidBST(root : TreeNode?) -> Bool {
        return helper(root,nil,nil);
    }
    
    //面试中，最常见的是二叉查找树，它是一种特殊的二叉树。它的特点就是左子树中节点的值都小于根节点的值，右子树中节点的值都大于根节点的值
    //给你一棵二叉树，怎么判断它是二叉查找树
    private func helper (_ node : TreeNode?,_ min : Int?,_ max : Int?) -> Bool {
        guard let node = node else {
            return false;
        }
        //所有右子节点都必须大于根节点
        if let min = min,node.val <= min {
            return false;
        }
        //所有左子节点都必须小于根节点
        if let max = max,node.val >= max {
            return false;
        }
        return helper(node.left, min, node.val) && helper(node.right, node.val, max);
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
    guard let root = root else {
        return 0;
    }
    return max(maxDepth(root.left), maxDepth(root.right))+1;
}




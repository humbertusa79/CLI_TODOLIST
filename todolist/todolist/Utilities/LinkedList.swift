//
//  LinkedList.swift
//  todolist
//
//  Created by HumbertoPartida on 3/16/25.
//

import Foundation

final class Node<T> {
    var value: T
    var next: Node<T>?
    init(value: T, next: Node<T>?) {
        self.value = value
        self.next = next
    }
}


final class LinkedList<T> {
    private var head: Node<T>?

    var begin: Node<T>? {
        return head
    }
    
    var isEmpty: Bool {
        return head == nil
    }
    
    init() {
        self.head = nil
    }
}

extension LinkedList {
    func push(value: T) {
        let newNode = Node(value: value, next: nil)
        guard !isEmpty else {
            head = newNode
            return
        }
        newNode.next = head
        head = newNode
    }
    
    func pop() -> T? {
        guard !isEmpty else {
            return nil
        }

        var node = head
        let value = node?.value
        defer {
            head = head?.next
            node = nil
        }
        return value
    }
    
    @discardableResult func deleteNodeAt(index: Int) -> T? {
        let nodes = nodeAt(index: index)
        var current = nodes.current
        var before = nodes.before
        if current === head {
            return pop()
        }
        
        defer {
            before?.next = current?.next
            current = nil
        }
        let value = current?.value
        return value
    }
    
    func nodeAt(index: Int) -> (current: Node<T>?, before: Node<T>?) {
        var iterator: Node<T>? = head
        var before: Node<T>? = nil
        var counter = 1
        while iterator != nil && counter < index {
            before = iterator
            iterator = iterator?.next
            counter += 1
        }
        return (iterator, before)
    }
}

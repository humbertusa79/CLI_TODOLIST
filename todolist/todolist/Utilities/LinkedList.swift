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
    var prev: Node<T>?
    init(value: T,
         next: Node<T>? = nil,
         prev: Node<T>? = nil) {
        self.value = value
        self.next = next
        self.prev = prev
    }
}


final class LinkedList<T> {
    private var head: Node<T>?
    private var tail: Node<T>?
    private var length: Int

    var begin: Node<T>? {
        return head
    }
    
    var end: Node<T>? {
        return tail
    }
    
    var count: Int {
        guard !isEmpty else { return 0 }
        return length
    }

    private var isEmpty: Bool {
        return head == nil
    }
    
    init() {
        self.head = nil
        self.tail = nil
        self.length = 0
    }
}

extension LinkedList {
    func enqueue(value: T) {
        let newNode = Node(value: value)
        newNode.next = head
        head?.prev = newNode
        head = newNode
        if tail == nil {
            tail = head
        }
        length += 1
    }

    func dequeue() -> T? {
        var node = tail
        let value = node?.value
        defer {
            tail = node?.prev
            node?.prev?.next = nil
            node?.prev = node?.next
            node = nil
            if tail == nil {
                head = tail
            }
            length -= 1
        }
        return value
    }
    
    private func pop() -> T? {
        var node = head
        let value = node?.value
        defer {
            head = node?.next
            node?.next?.prev = nil
            node?.prev = node?.next
            node = nil
            if head == nil {
                tail = head
            }
            length -= 1
        }
        return value
    }
    
    @discardableResult func deleteNodeAt(index: Int) -> T? {
        var node = nodeAt(index: index)
        
        if node === tail {
            return dequeue()
        }
        
        if node === head {
            return pop()
        }
        
        let value = node?.value

        defer {
            node?.prev?.next = node?.next
            node?.next?.prev = node?.prev
            node?.next = nil
            node?.prev = node?.next
            node = nil
        }
        return value
    }
    
    func traverse(perform: (Int,T?) -> Void) {
        guard !isEmpty else { return }
        var iterator: Node<T>? = tail
        var counter = 1
        while iterator !== head {
            perform(counter, iterator?.value)
            iterator = iterator?.prev
            counter += 1
        }
        perform(counter, iterator?.value)
    }
    
    func nodeAt(index: Int)  -> Node<T>? {
        var iterator: Node<T>? = tail
        var counter = 1
        while iterator !== head && counter < index {
            iterator = iterator?.prev
            counter += 1
        }
        return iterator
    }
}

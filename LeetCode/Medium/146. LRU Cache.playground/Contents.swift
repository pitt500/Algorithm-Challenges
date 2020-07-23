import Foundation

/*
 Design and implement a data structure for Least Recently Used (LRU) cache.
 It should support the following operations: get and put.
 get(key) - Get the value (will always be positive) of the key if the key exists in the cache, otherwise return -1.
 put(key, value) - Set or insert the value if the key is not already present.
 When the cache reached its capacity, it should invalidate the least recently used item before inserting a new item.
 The cache is initialized with a positive capacity.
 
 Follow up:
 Could you do both operations in O(1) time complexity?
 
 Example:
 LRUCache cache = new LRUCache( 2 /* capacity */ );
 cache.put(1, 1);
 cache.put(2, 2);
 cache.get(1);       // returns 1
 cache.put(3, 3);    // evicts key 2
 cache.get(2);       // returns -1 (not found)
 cache.put(4, 4);    // evicts key 1
 cache.get(1);       // returns -1 (not found)
 cache.get(3);       // returns 3
 cache.get(4);       // returns 4
 */

class Node{
  var prev: Node?
  var next: Node?
  let key: Int
  var value: Int
  
  init(_ key: Int = -1, _ value: Int = -1){
    self.key = key
    self.value = value
  }
}

class LRUCache {
  private var capacity: Int
  
  //Head and tail are the boundaries of the list
  // They will never be deleted
  // Empty list: Head <-> Tail
  private var head: Node?
  private var tail: Node?
  private var freeSpace: Int
  private var cache: [Int : Node]
  
  init(_ capacity: Int) {
    self.capacity = capacity
    head = Node()
    tail = Node()
    head?.next = tail
    tail?.prev = head
    
    freeSpace = capacity
    cache = [Int: Node]()
  }
  
  func get(_ key: Int) -> Int {
    guard let node = cache[key] else {
      return -1
    }
    
    updateLRU(node)
    return node.value
  }
  
  func put(_ key: Int, _ value: Int) {
    if let node = cache[key] {
      node.value = value
      updateLRU(node)
      return
    }
    
    let node = Node(key, value)
    cache[key] = node
    
    if freeSpace == 0 {
      let nodeToDelete = tail?.prev
      delete(nodeToDelete)
      cache[nodeToDelete!.key] = nil
      freeSpace += 1
    }
    
    moveToHead(node)
    freeSpace -= 1
  }
  
  private func updateLRU(_ node: Node?) {
    delete(node)
    moveToHead(node)
  }
  
  private func moveToHead(_ node: Node?) {
    node?.next = head?.next
    head?.next?.prev = node
    node?.prev = head
    head?.next = node
  }
  
  private func delete(_ node: Node?) {
    node?.next?.prev = node?.prev
    node?.prev?.next = node?.next
  }
}

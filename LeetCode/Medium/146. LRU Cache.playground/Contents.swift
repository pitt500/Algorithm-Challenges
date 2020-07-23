import Foundation

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

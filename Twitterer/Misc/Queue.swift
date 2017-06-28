//
//  Copyright © 2017 Stefano De Colli. All rights reserved.
//

/// Simple FIFO queue
public struct Queue<T> {
    private(set) var array = [T]()

    public init() {
        array.reserveCapacity(20)
    }

    public mutating func enqueue(_ element: T) {
        array.append(element)
    }

    public mutating func dequeue() -> T? {
        if array.count > 0 {
            return array.removeFirst()
        }

        return nil
    }
}

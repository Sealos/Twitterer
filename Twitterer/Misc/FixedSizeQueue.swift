//
//  Copyright © 2017 Stefano De Colli. All rights reserved.
//

// NOTE(sdecolli): Can be improved with a read and write pointer
// but was implemented like so for simplicity and ease of reading

/// Simple FIFO queue with a fixed size
public struct FixedSizeQueue<T> {
    public let maxSize: Int
    private var array: [T?]

    public var values: [T] {
        return array.compactMap {$0}
    }

    public init(maxSize: Int) {
        self.maxSize = max(maxSize, 1)

        self.array = [T?](repeating: nil, count: maxSize)
    }

    public mutating func enqueue(_ element: T) {
        array = [T?]([element] + array.dropLast())
    }
}

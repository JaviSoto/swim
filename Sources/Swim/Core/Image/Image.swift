public struct Image<P: PixelType, T: DataType> {
    public let width: Int
    public let height: Int
    
    @usableFromInline
    var data: [T]
    
    /// Returns underlying buffer.
    // `data` should be internal(set) but currently it can't.
    // So provide this instead.
    // https://bugs.swift.org/browse/SR-10340
    @inlinable
    public func getData() -> [T] {
        return data
    }

    @inlinable
    public init(width: Int, height: Int, data: [T]) {
        precondition(width > 0 && height > 0, "Image must have positive size.")
        precondition(data.count == width * height * P.channels,
                     "Size of `data` must be equal to `width` * `height` * number of channels")
        self.width = width
        self.height = height
        self.data = data
    }
    
    @inlinable
    public init(width: Int, height: Int, value: T) {
        let data = [T](repeating: value, count: width*height*P.channels)
        self.init(width: width, height: height, data: data)
    }
    
    @inlinable
    public init(width: Int, height: Int, color: Color<P, T>) {
        self = .createWithUnsafePixelRef(width: width, height: height) { ref in
            ref.initialize(to: color)
        }
    }
}

extension Image {
    @inlinable
    public var size: (width: Int, height: Int) {
        return (width, height)
    }
    
    @inlinable
    public var pixelCount: Int {
        return width * height
    }
}

extension Image: Equatable where T: Equatable {
    @inlinable
    public static func ==(lhs: Image, rhs: Image) -> Bool {
        guard lhs.size == rhs.size else {
            return false
        }
        return lhs.data == rhs.data
    }
}

extension Image: CustomStringConvertible {
    @inlinable
    public var description: String {
        let t = type(of: self)
        
        return "\(t)(width: \(width), height: \(height))"
    }
}

extension Image {
    /// Read/write pixel value.
    @inlinable
    public subscript(data index: Int) -> T {
        get {
            return data[index]
        }
        set {
            data[index] = newValue
        }
    }
    
    /// Get the index of specified pixel/channel in buffer.
    @inlinable
    public func dataIndex(x: Int, y: Int, c: Int = 0) -> Int {
        return Image.dataIndex(x: x, y: y, c: c, width: width, height: height)
    }
    
    /// Get the index of specified pixel/channel in buffer.
    ///
    /// This function can be used before initialize image.
    @inlinable
    public static func dataIndex(x: Int, y: Int, c: Int = 0, width: Int, height: Int) -> Int {
        precondition(0 <= x && x < width, "Index out of range.")
        precondition(0 <= y && y < height, "Index out of range.")
        precondition(0 <= c && c < P.channels, "Index out of range.")
        
        return (y * width + x) * P.channels + c
    }
}

extension Image {
    /// Call underlying buffer's `withUnsafeBufferPointer`.
    ///
    /// See `Array.withUnsafeBufferPointer` for further information.
    @inlinable
    public func withUnsafeBufferPointer<R>(_ body: (UnsafeBufferPointer<T>) throws -> R) rethrows -> R {
        return try data.withUnsafeBufferPointer(body)
    }
    
    /// Call underlying buffer's `withUnsafeMutableBufferPointer`.
    ///
    /// See `Array.withUnsafeMutableBufferPointer` for further information.
    @inlinable
    public mutating func withUnsafeMutableBufferPointer<R>(_ body: (inout UnsafeMutableBufferPointer<T>) throws -> R) rethrows -> R {
        return try data.withUnsafeMutableBufferPointer { bp in
            try body(&bp)
        }
    }
}

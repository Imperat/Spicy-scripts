import Darwin

@_cdecl("greet")
public func greet() -> UnsafePointer<CChar> {
        guard let cString = strdup("Hello from Swift!") else {
            fatalError("Failed to allocate memory for C string") // Handle allocation failure
        }
        return UnsafePointer(cString)
}

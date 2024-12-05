import Darwin

@_cdecl("buye")
public func buye() -> UnsafePointer<CChar> {
        guard let cString = strdup("buye from Swift!") else {
            fatalError("Failed to allocate memory for C string") // Handle allocation failure
        }
        return UnsafePointer(cString)
}

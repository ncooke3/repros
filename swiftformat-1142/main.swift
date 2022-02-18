#!/usr/bin/swift

// Error used in below example.
enum CustomError: Error {
    case emptyValue
}

// This function should return the given string
// if it is not `nil`, else throw an error.
func foo(_ bar: String?) throws -> String {
    return try bar ?? { throw CustomError.emptyValue }()
}

// Running swift-format on this file will transform this line:
//
//      return try data ?? { throw StorageError.readError }()
//
// into this line– which fails to compile.
//
//      return try data ?? throw StorageError.readError       // 🔺 Expected expression after operator
//


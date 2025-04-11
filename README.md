# SwBrotli

[![Swift](https://img.shields.io/badge/Swift-5.0+-orange.svg)](https://swift.org)
[![Platforms](https://img.shields.io/badge/Platforms-iOS%20|%20macOS-blue.svg)](https://www.apple.com)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](https://github.com/kirti-swiggy/SwBrotli/blob/main/LICENSE)

SwBrotli is a cocoapods distribution that provides a lightweight wrapper around Google's Brotli compression algorithm, making it easy to use Brotli compression and decompression in Swift projects.

Made with ❤️ and Swift

## Features

- Simple API for compressing and decompressing data using Brotli
- Support for configurable compression quality levels
- Thread-safe implementation
- Swift-native error handling
- Compatible with iOS and macOS platforms

## Requirements

- Swift 5.0+
- iOS 13.0+ or macOS 10.15+

## Installation

### Swift Package Manager

Add SwBrotli as a dependency to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/kirti-swiggy/SwBrotli.git", from: "1.0.0")
]
```

Then add SwBrotli to your target dependencies:

```swift
targets: [
    .target(
        name: "YourTarget",
        dependencies: ["SwBrotli"]),
]
```

## Usage

### Basic Compression and Decompression

```swift
import SwBrotli

// Compress data
let originalData = "Hello, Brotli!".data(using: .utf8)!
do {
    let compressedData = try Brotli.compress(data: originalData)
    print("Compressed size: \(compressedData.count) bytes")
    
    // Decompress data
    let decompressedData = try Brotli.decompress(data: compressedData)
    let decompressedString = String(data: decompressedData, encoding: .utf8)
    print("Decompressed: \(decompressedString ?? "nil")")
} catch {
    print("Error: \(error)")
}
```

### Customizing Compression Level

```swift
// Higher quality (better compression but slower)
let highQualityCompressed = try Brotli.compress(data: originalData, quality: 11)

// Lower quality (faster but less compression)
let lowQualityCompressed = try Brotli.compress(data: originalData, quality: 1)
```

### Using Streams for Large Data

```swift
// Create an input stream
let inputData = largeData
let inputStream = InputStream(data: inputData)
inputStream.open()

// Create an output stream
let outputStream = OutputStream.toMemory()
outputStream.open()

// Compress stream
try Brotli.compressStream(input: inputStream, output: outputStream)

// Get the compressed data
let compressedData = outputStream.property(forKey: .dataWrittenToMemoryStreamKey) as! Data

// Close streams
inputStream.close()
outputStream.close()
```

## Error Handling

SwBrotli provides custom error types to handle different failure scenarios:

```swift
do {
    let compressedData = try Brotli.compress(data: someData)
    // ...
} catch BrotliError.compressionFailed(let errorCode) {
    print("Compression failed with error code: \(errorCode)")
} catch BrotliError.decompressionFailed(let errorCode) {
    print("Decompression failed with error code: \(errorCode)")
} catch {
    print("Unknown error: \(error)")
}
```

## Implementation Details

SwBrotli is built on top of the official [Brotli library](https://github.com/google/brotli) by Google. The package includes a Swift wrapper that makes the C library's functionality accessible through a clean Swift API.

## Performance Considerations

- Brotli compression typically achieves better compression ratios than Gzip or Zlib, but may be slower for compression.
- Higher quality levels result in better compression at the cost of increased processing time.
- For web content, Brotli is particularly efficient for text-based assets like HTML, CSS, and JavaScript.

## License

SwBrotli is available under the MIT license. See the [LICENSE](LICENSE) file for more info.

## Acknowledgements

- [Google's Brotli Compression Format](https://github.com/google/brotli)

---
*Fun Fact: This README is generated entirely by Claude*

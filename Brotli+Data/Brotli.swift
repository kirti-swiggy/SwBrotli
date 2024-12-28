//
//  Brotli.swift
//  BrotiiSample
//
//  Created by Kirti Kumar Verma on 28/12/24.
//

import Brotli
import Foundation

extension Data {
    func decompress(
        maximumDecompressedSize: Int = defaultMaximumDecompressedSize
    ) -> Result<Data, DecompressionError> {
        var decodedBuffer = [UInt8](repeating: 0, count: maximumDecompressedSize)
        var decodedSize: Int = decodedBuffer.count
        
        let decompressResult = BrotliDecoderDecompress(
            self.count,
            [UInt8](self),
            &decodedSize,
            &decodedBuffer
        )
        
        if decompressResult == .success {
            return .success(Data(decodedBuffer[0..<decodedSize]))
        } else {
            return .failure(.invalidData)
        }
    }
    
    func compress(
        quality: Int32 = defaultQuality,
        lgwin: Int32 = defaultWindow,
        mode: EncoderMode = .generic
    ) -> Result<Data, CompressionError> {
        var encodedBuffer = [UInt8](repeating: 0, count: self.count)
        var encodedSize: Int = encodedBuffer.count
        let compressResult = BrotliEncoderCompress(
            quality,
            lgwin,
            mode.encoderValue,
            self.count,
            [UInt8](self),
            &encodedSize,
            &encodedBuffer
        )
        
        if compressResult == .success {
            return .success(Data(encodedBuffer[0..<encodedSize]))
        } else {
            return .failure(.compressionFailed)
        }
    }
}

enum EncoderMode {
    case font
    case generic
    case text
    
    fileprivate var encoderValue: BrotliEncoderMode {
        switch self {
        case .font:
            return BROTLI_MODE_FONT
        case .generic:
            return BROTLI_MODE_GENERIC
        case .text:
            return BROTLI_MODE_TEXT
        }
    }
}


extension Data {
    static var defaultWindow: Int32 {
        return 19
    }

    static var defaultQuality: Int32 {
        return BROTLI_DEFAULT_QUALITY
    }

    static var defaultMaximumDecompressedSize: Int {
        return 1 << 19
    }
}


enum CompressionError: Error {
    case compressionFailed
}
    
enum DecompressionError: Error {
    case invalidData
}

extension BrotliDecoderResult {
    fileprivate static var success: BrotliDecoderResult {
        return BROTLI_DECODER_RESULT_SUCCESS
    }
}

extension Int32 {
    fileprivate static var success: Int32 {
        return BROTLI_TRUE
    }
}

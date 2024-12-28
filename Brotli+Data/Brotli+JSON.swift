//
//  Brotli+JSON.swift
//  BrotliSample
//
//  Created by Kirti Kumar Verma on 28/12/24.
//

import Foundation

struct BrotliJSONEncoder {
    private let jsonEncoder = JSONEncoder()
    
    func encode<T: Encodable>(_ object: T) -> Result<Data, Error> {
        return encode(object, outputFormatting: [.withoutEscapingSlashes])
    }
    
    func encode<T: Encodable>(_ object: T, outputFormatting: JSONEncoder.OutputFormatting) -> Result<Data, Error> {
        jsonEncoder.outputFormatting = outputFormatting
        return Result { try jsonEncoder.encode(object) }.flatMap { $0.compress(mode: .text).mapError { $0 as Error } }
    }
}

struct BrotliJSONDecoder {
    private let jsonDecoder = JSONDecoder()
    
    func decode<T: Decodable>(data: Data) -> Result<T, Error> {
        data.decompress()
            .mapError { $0 as Error }
            .flatMap { decompressedData in
                Result { try jsonDecoder.decode(T.self, from: decompressedData) }
            }
    }
}

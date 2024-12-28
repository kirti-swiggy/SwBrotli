//
//  ContentView.swift
//  BrotliSample
//
//  Created by Kirti Kumar Verma on 28/12/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var gzipResponseSize: Int?
    @State private var brotliResponseSize: Int?
    
    var body: some View {
        VStack {
            Text("Response bytes: \n")
                .font(.headline)
            
            if let brotliResponseSize {
                Text("brotli compression: \(brotliResponseSize)")
            }
        }
        .task {
            test()
            
            brotliResponseSize = await NetworkManager().testBrotliCompression(encoding: .br)
        }
    }
    
    func test() {
        let compressedFilePath = Bundle.main.path(forResource: "output", ofType: "json.br")
        
        guard let filePath = compressedFilePath else {
            debugPrint("Failed to find .br file in the project directory")
            return
        }
        do {
            let compressedData = try Data(contentsOf: URL(fileURLWithPath: filePath))
            let decompressionResult = compressedData.decompress()
            
            switch decompressionResult {
            case .success(let decompressedData):
                // Convert the decompressed data back to a JSON string
                if let decompressedJSONString = String(data: decompressedData, encoding: .utf8) {
                    debugPrint("Decompressed JSON String: \(decompressedJSONString)")
                } else {
                    debugPrint("Failed to convert decompressed data to string")
                }
            case .failure(let error):
                debugPrint("Decompression failed with error: \(error)")
            }
        } catch {
            debugPrint("Failed to read compressed data from file: \(error)")
        }
    }
}

#Preview {
    ContentView()
}

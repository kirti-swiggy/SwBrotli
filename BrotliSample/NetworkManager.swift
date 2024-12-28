//
//  NetworkManager.swift
//  BrotliSample
//
//  Created by Kirti Kumar Verma on 28/12/24.
//

import Foundation
import Brotli

final class NetworkManager {
    
    enum EncodingType: String {
        case gzip
        case br
    }
    
    func testBrotliCompression(encoding: EncodingType = .br) async -> Int? {
        let url = URL(string: "https://instamart-media-assets.swiggy.com/Farhan/presearch_json.json")!
        var request = URLRequest(url: url)
        request.setValue(encoding.rawValue, forHTTPHeaderField: "Accept-Encoding")
        
        guard let (data, response) = try? await URLSession.shared.data(for: request) else {
            return nil
        }
        
        if let httpResponse = response as? HTTPURLResponse,
           let json = try? JSONSerialization.jsonObject(with: data) {
            
            let contentEncoding = httpResponse.value(forHTTPHeaderField: "Content-Encoding")
            print("Content-Encoding: ", contentEncoding) // Should show "br" if Brotli was used
            print("Response size: \(data.count) bytes")
            
            print("Successfully decoded JSON response")
            print(json)
            
            return data.count
        } else {
            return nil
        }
    }
}

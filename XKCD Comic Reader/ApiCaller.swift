//
//  ApiCaller.swift
//  XKCD Comic Reader
//
//  Created by teddy juhlin-henricson on 2022-07-26.
//

import Foundation

final class ApiCaller {
    // TODO: Calls  the api https://xkcd.com/info.0.json to get the info about the (latest) comic
    
    init() {}
    
    func fetch(url: String) async {
        guard let url = URL(string: url) else {
            return
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            let httpResponse = response as? HTTPURLResponse
            if let httpResponse = httpResponse {
                if httpResponse.statusCode == 200 {
                    let decodedData = parse(data)
                    print(">> Decoded data: \(decodedData)")
                } else {
                    print(">> HTTP Response Status Code: \(httpResponse.statusCode)")
                    print(">> HTTP Response: \(httpResponse)")
                }
            }
        } catch {
            print(error)
        }
        
    }
    
    func parse(_ data: Data) -> XKCDData {
        do {
            return try JSONDecoder().decode(XKCDData.self, from: data)
        } catch {
            print(error)
            return XKCDData()
        }
    }
}

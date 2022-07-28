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
    
    func fetch<T: Codable>(url: URL?) async -> T? {
        
        guard let url = url else {
            return nil
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            let httpResponse = response as? HTTPURLResponse
            if let httpResponse = httpResponse {
                if httpResponse.statusCode == 200 {
                    if let data = data as? T {
                        return data
                    }
                    return parse(data)
                } else {
                    print(">> HTTP Response Status Code: \(httpResponse.statusCode)")
                    print(">> HTTP Response: \(httpResponse)")
                }
            }
        } catch {
            print(error)
        }
        
        return nil
    }
    
    func parse<T: Codable>(_ data: Data) -> T? {
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            print(error)
            return nil
        }
    }
}

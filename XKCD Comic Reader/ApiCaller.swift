//
//  ApiCaller.swift
//  XKCD Comic Reader
//
//  Created by teddy juhlin-henricson on 2022-07-26.
//

import Foundation

protocol ApiCallerProtocol {
    func fetch(url: String) async
    func parse()
}

final class ApiCaller: ApiCallerProtocol {
    // TODO: Calls  the api https://xkcd.com/info.0.json to get the info about the (latest) comic
    
    init() {}
    
    func fetch(url: String) async {
        print("Hello from fetch()")
        guard let url = URL(string: url) else {
            return
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            let httpResponse = response as? HTTPURLResponse
            if let httpResponse = httpResponse {
                if httpResponse.statusCode == 200 {
                    print("Fetched!")
                    print(data)
                }
            }
        } catch {
            print(error)
        }
        
    }
    
    func parse() {
        print("Hello from parse()")
    }
}


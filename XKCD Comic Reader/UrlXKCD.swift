//
//  UrlXKCD.swift
//  XKCD Comic Reader
//
//  Created by teddy juhlin-henricson on 2022-07-27.
//

import Foundation

struct UrlXKCD {
    private var xkcdEnd = "info.0.json"
    private var xkcdUrl = "https://xkcd.com/"
    private(set) var xkcdNumber: Int = -1
    
    func get(_ latest: Bool = true, for number: Int = -1) -> String {
        if latest {
            return xkcdUrl + xkcdEnd
        }
        return xkcdUrl + "/" + String(xkcdNumber) + "/" + xkcdEnd
    }
    
    mutating func setComicNumber(_ number: Int?) {
        guard let number = number else {
            xkcdNumber = -1
            return
        }
        xkcdNumber = number
    }
}

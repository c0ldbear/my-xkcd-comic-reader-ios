//
//  UrlXKCD.swift
//  XKCD Comic Reader
//
//  Created by teddy juhlin-henricson on 2022-07-27.
//

import Foundation

extension URL {
    init?(number: Int = -1) {
        self.init(string: "https://xkcd.com/" + (number < 0 ? "" : "\(number)/") + "info.0.json")
    }
}

//
//  XKCDData.swift
//  XKCD Comic Reader
//
//  Created by teddy juhlin-henricson on 2022-07-26.
//

import Foundation

struct XKCDData: Codable {
    // Necessary
    var title: String?
    var alt: String?
    var img: String?
    
    // Extra information from API
    var safe_title: String?
    var num: Int?
    var day: String?
    var month: String?
    var year: String?
}

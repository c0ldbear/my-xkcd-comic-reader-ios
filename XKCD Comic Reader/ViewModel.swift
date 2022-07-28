//
//  ViewModel.swift
//  XKCD Comic Reader
//
//  Created by teddy juhlin-henricson on 2022-07-26.
//

import Foundation

final class ViewModel {
    
//    var nextNumber: Int = -1
    var nextNumber: Int = 2639
    
    let apiCaller = ApiCaller()
    
    init() {}
    
    func fetchXKCD() async -> (XKCDData?, Data?) {
        
        let xkcdData: XKCDData? = await apiCaller.fetch(url: URL(number: nextNumber))
        guard let imgUrlString = xkcdData?.img else {
            return (nil, nil)
        }
        if nextNumber < 0 {
            nextNumber = xkcdData?.num ?? -1
        }
        
        let imgData: Data? = await apiCaller.fetch(url: URL(string: imgUrlString))
        
        return (xkcdData, imgData)
    }
}

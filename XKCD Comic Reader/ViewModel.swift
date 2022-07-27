//
//  ViewModel.swift
//  XKCD Comic Reader
//
//  Created by teddy juhlin-henricson on 2022-07-26.
//

import Foundation

final class ViewModel {
    
//    var xkcdUrl = UrlXKCD()
    var nextNumber: Int = -1
    
    let apiCaller = ApiCaller()
    
    init() {}
    
    func fetchXKCD() async -> (XKCDData?, Data?) {
        
        let xkcdData: XKCDData? = await apiCaller.fetch(url: URL(number: nextNumber))
        guard let imgUrlString = xkcdData?.img else {
            return (nil, nil)
        }
        // TODO: How do we keep track of the latest comic number? Save somewhere? and if so, how? or do we accept that the app will always display the latest comic first?
        if nextNumber < 0 {
            nextNumber = xkcdData?.num ?? -1
//            xkcdUrl.setComicNumber(currentNumber)
        }
        
        let imgData: Data? = await apiCaller.fetch(url: URL(string: imgUrlString))
        
        return (xkcdData, imgData)
    }
}

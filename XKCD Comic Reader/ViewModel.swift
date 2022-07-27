//
//  ViewModel.swift
//  XKCD Comic Reader
//
//  Created by teddy juhlin-henricson on 2022-07-26.
//

import Foundation

final class ViewModel {
    let xkcdUrl = "https://xkcd.com/info.0.json"
    
    let apiCaller = ApiCaller()
    
    init() {}
    
    func fetchXKCD() async -> (XKCDData?, Data?) {
        let xkcdData: XKCDData? = await apiCaller.fetch(url: self.xkcdUrl)
        guard let imgUrlString = xkcdData?.img else {
            return (nil, nil)
        }
        
        let imgData: Data? = await apiCaller.fetch(url: imgUrlString)
        
        return (xkcdData, imgData)
    }
    
}

//
//  ViewModel.swift
//  XKCD Comic Reader
//
//  Created by teddy juhlin-henricson on 2022-07-26.
//

import Foundation

final class ViewModel {
    
    var xkcdUrl = UrlXKCD()
    
    let apiCaller = ApiCaller()
    
    init() {}
    
    func fetchXKCD(for number: Int? = nil) async -> (XKCDData?, Data?) {
        if let comicNumber = number {
            xkcdUrl.setComicNumber(comicNumber)
        }
        let xkcdData: XKCDData? = await apiCaller.fetch(url: xkcdUrl.get())
        guard let imgUrlString = xkcdData?.img else {
            return (nil, nil)
        }
        // TODO: How do we keep track of the latest comic number? Save somewhere? and if so, how? or do we accept that the app will always display the latest comic first?
        
        let imgData: Data? = await apiCaller.fetch(url: imgUrlString)
        
        return (xkcdData, imgData)
    }
}

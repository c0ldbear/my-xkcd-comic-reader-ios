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
//        let imgData = await fetchImgXKCD(fromUrl: xkcdData?.img)
        let imgData: Data? = await apiCaller.fetch(url: xkcdData?.img as! String)
        return (xkcdData, imgData)
    }
    
    private func fetchImgXKCD(fromUrl imgUrl: String?) async -> Data? {
        guard let imgUrl = imgUrl,
              let url = URL(string: imgUrl) else {
            return nil
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            let httpResponse  = response as? HTTPURLResponse
            if httpResponse?.statusCode == 200 {
                return data
            }
        } catch {
            print(error)
        }
        
        return nil
    }
    
}

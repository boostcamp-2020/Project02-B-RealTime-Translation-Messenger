//
//  DefaultImageFactory.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/11/24.
//

import Foundation

struct DefaultImageFactory: ImageFactory {
    
    private static let defaultImages = [
        "https://kr.object.ncloudstorage.com/papagotalk/skyblue.png",
        "https://kr.object.ncloudstorage.com/papagotalk/red.png",
        "https://kr.object.ncloudstorage.com/papagotalk/orange.png",
        "https://kr.object.ncloudstorage.com/papagotalk/gray.png"
    ]
    
    func randomImageURL() -> String {
        guard let random = Self.defaultImages.randomElement() else {
            return ""
        }
        return random
    }
}

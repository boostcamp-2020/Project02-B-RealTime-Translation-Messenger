//
//  ImageFactory.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/11/24.
//

import Foundation

struct ImageFactory: ImageFactoryProviding {
    
    private static let defaultImages = [
        "https://kr.object.ncloudstorage.com/papagotalk/defaultimage/1.png",
        "https://kr.object.ncloudstorage.com/papagotalk/defaultimage/2.png",
        "https://kr.object.ncloudstorage.com/papagotalk/defaultimage/3.png",
        "https://kr.object.ncloudstorage.com/papagotalk/defaultimage/4.png",
        "https://kr.object.ncloudstorage.com/papagotalk/defaultimage/5.png",
        "https://kr.object.ncloudstorage.com/papagotalk/defaultimage/6.png",
        "https://kr.object.ncloudstorage.com/papagotalk/defaultimage/7.png",
        "https://kr.object.ncloudstorage.com/papagotalk/defaultimage/8.png",
        "https://kr.object.ncloudstorage.com/papagotalk/defaultimage/9.png",
        "https://kr.object.ncloudstorage.com/papagotalk/defaultimage/10.png",
        "https://kr.object.ncloudstorage.com/papagotalk/defaultimage/11.png",
        "https://kr.object.ncloudstorage.com/papagotalk/defaultimage/12.png",
        "https://kr.object.ncloudstorage.com/papagotalk/defaultimage/13.png",
        "https://kr.object.ncloudstorage.com/papagotalk/defaultimage/14.png",
        "https://kr.object.ncloudstorage.com/papagotalk/defaultimage/15.png",
        "https://kr.object.ncloudstorage.com/papagotalk/defaultimage/16.png",
        "https://kr.object.ncloudstorage.com/papagotalk/defaultimage/17.png",
        "https://kr.object.ncloudstorage.com/papagotalk/defaultimage/18.png",
        "https://kr.object.ncloudstorage.com/papagotalk/defaultimage/19.png",
        "https://kr.object.ncloudstorage.com/papagotalk/defaultimage/20.png",
        "https://kr.object.ncloudstorage.com/papagotalk/defaultimage/21.png",
        "https://kr.object.ncloudstorage.com/papagotalk/defaultimage/22.png",
        "https://kr.object.ncloudstorage.com/papagotalk/defaultimage/23.png",
        "https://kr.object.ncloudstorage.com/papagotalk/defaultimage/24.png",
        "https://kr.object.ncloudstorage.com/papagotalk/defaultimage/25.png"
    ]
    
    func randomImageURL() -> String {
        guard let random = Self.defaultImages.randomElement() else {
            return ""
        }
        return random
    }
}

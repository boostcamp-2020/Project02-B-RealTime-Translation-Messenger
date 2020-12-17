//
//  PapagoAPIServiceProviding.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/12/06.
//

import Foundation
import RxSwift

protocol PapagoAPIServiceProviding {
    func requestTranslation(request: TranslationRequest) -> Maybe<String> 
}

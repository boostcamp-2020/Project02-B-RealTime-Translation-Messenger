//
//  PapagoAPIServiceMockSuccsess.swift
//  PapagoTalkTests
//
//  Created by Byoung-Hwi Yoon on 2020/12/08.
//

import Foundation
import RxSwift
@testable import PapagoTalk

class PapagoAPIServiceMock: PapagoAPIServiceProviding {
    func requestTranslation(request: TranslationRequest) -> Maybe<String> {
        return .just("TranslatedText")
    }
}

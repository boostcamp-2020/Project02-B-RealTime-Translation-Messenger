
# PapagoTalk iOS App
> [프로젝트02-B] 실시간 번역 메신저

[![Swift](https://img.shields.io/badge/swift-v5.1-orange?logo=swift)](https://developer.apple.com/kr/swift/)
[![Xcode](https://img.shields.io/badge/xcode-v12.1-blue?logo=xcode)](https://developer.apple.com/kr/xcode/)
[![Releases](https://img.shields.io/github/v/release/boostcamp-2020/Project02-B-RealTime-Translation-Messenger)](https://github.com/boostcamp-2020/Project02-B-RealTime-Translation-Messenger/releases)

<br>

## 📌 RxSwift와 ReactorKit을 이용한 Architecture

### RxSwift

#### 도입 배경

1️⃣ 복잡한 비동기 처리를 Binding과 Operator들을 통해 쉽게 처리 가능하다는 장점

2️⃣ 관련된 콜백 함수를 선언적으로 작성할 수 있다는 장점

3️⃣ 새로운 기술적 도전

#### 적용 방식

➡️ Network 요청의 Result값을 Observable로 반환

➡️ 다양한 데이터 발행자 활용 (Observable, Maybe, Driver, BehaviorSubject 등)

➡️ RxCocoa를 사용하여 View의 Event Binding

#### 좋았던 점

1️⃣ 비동기 콜백 함수를 선언적으로 작성

2️⃣ Operator를 통한 흐름 처리

3️⃣ 관련 내용의 코드가 선언적으로 모여 있음

<br>

### ReactorKit

#### 도입 배경

1️⃣ 일관된 상태 관리의 필요성

2️⃣ 여러 Stream끼리 의존성을 가지는 형태 지양 (버그 발생 가능성 증가, 디버깅 어려움, 테스트 어려움)

3️⃣ 협업을 위한 표준화된 틀

#### 적용 방식

➡️ Scene 별로 `ViewController` - `Reactor` - `Model` 구조로 구현

➡️ 사용자의 Event Input을 `Reactor`의 `Action`과 Binding

➡️ `Reactor` 에서 Model을 통한 Logic 처리 및 `State` 변경

➡️ `State` 의 변경을 View에 Binding

<img width="700" alt="ReactorKit" src="https://i.imgur.com/f8ZaeOk.png">

#### 좋았던 점

1️⃣ 단방향 데이터 흐름과 일관된 상태 관리를 통해 스트림간의 의존성 저하 및 디버깅 용이

2️⃣ 테스트 가능한 구조로 테스트 용이

3️⃣ 표준화된 코드 틀로 협업 과정에서 코드 이해도 & 생산성 향상

<br>

### Coordinator Pattern

#### 도입 배경

1️⃣ 여러 화면간의 Navigation 및 Present 로직 필요

2️⃣ `ViewController` 간의 의존성 증가

3️⃣ 화면 전달 시 필요한 데이터 전달 

#### 적용 방식

<img width="700" alt="Coordinator" src="https://user-images.githubusercontent.com/68672528/102089445-8dfe4a80-3e5f-11eb-95a2-9c9095d1811d.png">

#### 좋았던 점

1️⃣ 화면 전환의 책임 분리

2️⃣ `ViewController`간의 의존성 감소

3️⃣ `ViewController`의 Volume 축소

<br>

## 📌 확장성과 유지보수를 고려한 설계

### Dependency Injection (DI)

#### 도입 배경

1️⃣ 유지 보수를 위한 객체간 종속성 및 의존성 감소 필요

2️⃣ 유연성과 확장성을 위한 낮은 결합도 필요

3️⃣ Testable한 구조 필요

#### 적용 방식

➡️ 객체간 관계를 모두 프로토콜을 활용하여 의존성 역전

➡️ Coordinator에서 ViewController 생성 시 Reactor 주입

➡️ Reactor 생성 시 필요한 Model 주입

#### 좋았던 점

1️⃣ 모든 객체가 구체타입이 아닌 프로토콜타입을 참조하여 변화에 용이

2️⃣ Mock객체를 통한 테스트 가능

<br>

### Case 1 - Language

#### 과정

1️⃣ 언제든지 지원하는 언어가 추가될 수 있는 서비스인 만큼, 요구사항인 한국어/영어 뿐만 아니라 다른 언어도 쉽게 추가될 수 있는 확장성을 고려한 구조 설계 필요성 인지

2️⃣ 프로젝트 기획 단계 부터 웹 분야의 팀원들과의 적극적인 의사소통을 통하여, 언제든지 다른 언어도 쉽게 지원 할 수 있는 확장적인 구조 설계의 필요성 어필

3️⃣  iOS 프로젝트 내에서도 요구사항인 한국어/영어 지원을 목표로 하되, 추가적인 언어가 지원되는 경우 최소한의 변경으로 적용 가능한 구조 설계를 목표로 설정

4️⃣ UI도 변경 없이 확장할 수 있도록 언어 선택버튼을 PickerView로 대체하는 등의 방식 선택

#### 결과

➡️  실제적으로 프로젝트 중반 지원하는 언어를 추가하는 과정에서 Language Enum type의 case를 추가하는 것 만으로 변경사항 적용하였으며, 현재 한국어/영어/일본어/중국어 지원 가능

➡️  Papago NMT API의 번역 지원 언어 추가와 Papago Language Detection API 감지 언어 추가에 따라, 적은 변화로 추가적인 언어 지원 가능

<br>

### Case 2 - Message

#### 과정

1️⃣  보낸 메시지/받은 메시지, 원본 메시지/번역 메시지 등 다양한 메시지 타입 존재

2️⃣  다양한 타입의 메시지에 해당하는 Cell을 하나의 Protocol로 추상화하여 활용

3️⃣  MessagePaser, MessageBox 등의 모델을 활용한 책임 분리 및 단일 책임 원칙 적용

### 결과

➡️  코드 중복 제거 및 메시지 형식 추가에 빠르고 쉬운 대응 가능

➡️  실제로 프로젝트 중반에 시스템 메시지 적용, 보낸 메시지의 번역 메시지 적용 등 다양한 변화에 손쉬운 대처를 경험

<br>

## 📌 더 나은 사용자 경험을 위한 UX/UI

### Launch Screen

➡️ App이 Launching되는 동안 애니메이션 추가

<img width="350" alt="Launch Screen" src="https://user-images.githubusercontent.com/68672528/102089558-bede7f80-3e5f-11eb-8efd-2cf941977610.gif">

<br>

### Localization

➡️ 번역 채팅 앱 특성상 다양한 언어를 가진 사용자가 이용할 수 있다는 점을 고려하여 Localization 적용

➡️ 사용자 기기에서 선택한 언어에 따른 Localization

➡️ 현재 지원 언어 : 한국어, 영어, 일본어, 중국어

<img width="955" alt="Localization" src="https://user-images.githubusercontent.com/68672528/102090417-ce11fd00-3e60-11eb-994d-e8c938771060.png">

<br>

### 다크모드 지원

<img width="975" alt="DarkMode1" src="https://user-images.githubusercontent.com/68672528/102090459-d833fb80-3e60-11eb-9db2-0f4706edb072.png">

<img width="975" alt="DarkMode2" src="https://user-images.githubusercontent.com/68672528/102090474-dcf8af80-3e60-11eb-92f2-2172eafa9253.png">

<br>

### 채팅 화면

➡️ 해당 날짜의 첫 메시지 상단에만 날짜 표시

➡️ 메시지의 시간 표시 & 같은 시각의 메시지는 해당 시각의 마지막 메세지에만 시간 표시

➡️ 상대방의 닉네임/이미지 표시

- 원본 메시지와 번역 메시지가 함께 올 경우, 다음 메시지와의 구분을 위하여 메시지 마다 상대방의 닉네임과 이미지 표시
- 원본 메시지만 연속적으로 오는 경우, 분단위로 상대방의 닉네임과 이미지를 표시

<img width="800" alt="ChatView" src="https://user-images.githubusercontent.com/68672528/102090561-f4d03380-3e60-11eb-9b09-ea1057c2c264.png">

<br>

#### 채팅방 서랍(Drawer)

➡️ 채팅방의 Drawer를 통해 현재 참가중인 사용자 목록 확인 가능

➡️ 채팅방의 코드 복사 버튼을 통해 현재 채팅방의 코드 복사 기능

<img width="350" alt="Drawer" src="https://user-images.githubusercontent.com/68672528/102090588-fc8fd800-3e60-11eb-9e25-69a6bb55b200.gif">

<br>

#### 채팅방 설정

➡️ 동일 언어 번역 결과 설정

- 사용자와 같은 언어를 사용하는 사람과 대화할 때, 메시지의 번역본이 원문과 중복되는 결과가 나오는 경우, 사용자의 선택에 따라 그것을 화면에 표시할지 여부 설정 가능

<img width="800" alt="ChatRoomSetting" src="https://user-images.githubusercontent.com/68672528/102090680-1af5d380-3e61-11eb-9bf9-408c2aa92631.png">

<br>

#### 키보드 처리

➡️  키보드의 Show와 Hide에 따른 InputBar 및 음성인식 버튼 애니메이션

➡️  키보드가 보여지고 숨겨질 때, 보고있던 마지막 메시지를 기준으로 정렬되도록 처리 

<img width="350" alt="Keyboard" src="https://user-images.githubusercontent.com/68672528/102091335-0b2abf00-3e62-11eb-8a90-244f2355ab46.gif">

<br>

### 음성 인식 & 실시간 번역

➡️ Speech Framework SFSpeechRecognizer를 활용하여 음성 인식

➡️ STT(Speech-To-Text)로 인식된 텍스트 결과를 papago NMT API를 이용하여 실시간으로 번역

➡️ 음성 인식을 시작하면, 소리를 인식하고 있다는 것을 인지시켜주는 애니메이션

<img width="350" alt="STT" src="https://user-images.githubusercontent.com/68672528/102091508-42996b80-3e62-11eb-80d0-404cdb273f40.gif">

<br>

### 음성 인식 버튼

➡️ 채팅 화면에서 Floating Button 형태로 음성 인식 버튼 제공

➡️ 위치에 따라 채팅을 가릴 수 있는 문제점을 인식하여, 사용자가 드래그를 통해서 버튼 위치를 자유롭게 지정하도록 처리

➡️ 사용자의 빈도 및 기호에 맞게 음성 인식 버튼 사이즈를 크게, 중간, 작게, 사용 안함으로 설정 가능

➡️ 키보드의 Show에 따라 가려지지 않고 함께 위치 변경 및 키보드 Hide에 따라 제자리로 이동

➡️ 음성 인식 버튼을 눌러서 음성 인식 화면을 Present할 때, 자연스러운 애니메이션

| 위치 이동 | 크기 조절 | 키보드 처리 | 애니메이션 |
|:----:|:----:|:----:|:----:|
| <img width="350" alt="SpeechRecognizer" src="https://user-images.githubusercontent.com/68672528/102091570-580e9580-3e62-11eb-9c20-dba211e4ab89.gif"> | <img width="350" alt="SpeechSettingButton" src="./gif/5_SpeechButtonSetting.gif"> | <img width="350" alt="SpeechButtonKeyboard" src="https://user-images.githubusercontent.com/68672528/102094469-b426e900-3e65-11eb-9621-3b870cc0a61c.gif"> | <img width="350" alt="SpeechRecognitionAnimation" src="https://user-images.githubusercontent.com/68672528/102094476-b5f0ac80-3e65-11eb-9e68-a6dea3086fd0.gif"> |

<br>

## 📌 Apollo-iOS를 활용한 GraphQL 통신

#### 도입 배경

1️⃣  기존에 사용하였던 REST API와 달리 처음 적용하는 GraphQL에 적응할 필요성 대두

2️⃣  Apollo가 제공하는 강력한 CodeGenerating 기능

#### 적용 방식

➡️ typealias와 extension을 적극적으로 활용하여 Generating된 코드를 간단하게 이용

➡️ Observable한 리턴값을 반환하도록 하여, RxSwift와의 연동

➡️ Interceptor를 활용한 JWT토큰 인증

#### 좋았던 점

1️⃣ 단일화된 EndPoint

2️⃣ 직접 작성한 쿼리를 통해 필요한 데이터를 선택하여 얻어 올 수 있어 백엔드와의 협업에서의 높은 자유도

<br>

## 📌 사용자의 Data Storage

### UserDefaults

➡️ 사용자의 닉네임, 이미지, 언어, Setting 값 등을 UserDefaults로 저장

➡️ 앱이 재시동 되어도 정보 유지

➡️ Property Wrapper를 활용하여 UserDefaults 접근

### Keychain

➡️ 사용자의 JWT 토큰을 Keychain에 저장

➡️ Property Wrapper를 활용하여 Keychain 접근

### CoreData

➡️ 사용자의 채팅방 입장 History를 CoreData에 저장

➡️ History를 통해 해당 채팅방 재입장 가능

<br>

## 📌 핵심 로직 Unit Test

### Reactor Tests

➡️ 모든 Scene의 Reactor Unit Test 진행

➡️ Action에 따라 로직을 수행하고 변경된 State의 결과 값을 Test하는 방식으로 수행

➡️ Mock 객체와 Stub 객체 활용

### Model Tests

➡️ Scene별 Model의 Unit Test 진행

➡️ 로직이 잘 작동하는지 Test하는 방식으로 수행

➡️ Mock 객체와 Stub 객체 활용

<br>

## Library
- [Apollo-iOS](https://github.com/apollographql/apollo-ios)
- [ReactorKit](https://github.com/ReactorKit/ReactorKit)
- [RxSwift](https://github.com/ReactiveX/RxSwift)
- [RxCocoa](https://github.com/ReactiveX/RxSwift)
- [RxGesture](https://github.com/RxSwiftCommunity/RxGesture)
- [RxDataSources](https://github.com/RxSwiftCommunity/RxDataSources)
- [Kingfisher](https://github.com/onevcat/Kingfisher)
- [Toaster](https://github.com/devxoul/Toaster)
- [SwiftLint](https://github.com/realm/SwiftLint)

## Requirements
 - iOS 12.0 +

## Cocoapods
```ruby
target 'PapagoTalk' do
  pod "Apollo"
  pod "Apollo/WebSocket"
  pod "SwiftLint"
  pod "ReactorKit"
  pod "RxCocoa"
  pod "Kingfisher"
  pod "RxGesture"
  pod "RxDataSources"
  pod "Toaster"
end
```

## Installation
```
$ pod install
```

## Author
- 송민관 [@Minkwan-Song](https://github.com/Minkwan-Song)
- 윤병휘 [@ByoungHwi](https://github.com/ByoungHwi)

// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class CreateRoomMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation CreateRoom($nickname: String!, $avatar: String!, $lang: String!) {
      createRoom(nickname: $nickname, avatar: $avatar, lang: $lang) {
        __typename
        userId
        roomId
        code
        token
      }
    }
    """

  public let operationName: String = "CreateRoom"

  public var nickname: String
  public var avatar: String
  public var lang: String

  public init(nickname: String, avatar: String, lang: String) {
    self.nickname = nickname
    self.avatar = avatar
    self.lang = lang
  }

  public var variables: GraphQLMap? {
    return ["nickname": nickname, "avatar": avatar, "lang": lang]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("createRoom", arguments: ["nickname": GraphQLVariable("nickname"), "avatar": GraphQLVariable("avatar"), "lang": GraphQLVariable("lang")], type: .nonNull(.object(CreateRoom.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(createRoom: CreateRoom) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "createRoom": createRoom.resultMap])
    }

    public var createRoom: CreateRoom {
      get {
        return CreateRoom(unsafeResultMap: resultMap["createRoom"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "createRoom")
      }
    }

    public struct CreateRoom: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["createRoomResponse"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("userId", type: .nonNull(.scalar(Int.self))),
          GraphQLField("roomId", type: .nonNull(.scalar(Int.self))),
          GraphQLField("code", type: .nonNull(.scalar(String.self))),
          GraphQLField("token", type: .nonNull(.scalar(String.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(userId: Int, roomId: Int, code: String, token: String) {
        self.init(unsafeResultMap: ["__typename": "createRoomResponse", "userId": userId, "roomId": roomId, "code": code, "token": token])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var userId: Int {
        get {
          return resultMap["userId"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "userId")
        }
      }

      public var roomId: Int {
        get {
          return resultMap["roomId"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "roomId")
        }
      }

      public var code: String {
        get {
          return resultMap["code"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "code")
        }
      }

      public var token: String {
        get {
          return resultMap["token"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "token")
        }
      }
    }
  }
}

public final class EnterRoomMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation EnterRoom($nickName: String!, $avatar: String!, $language: String!, $code: String!) {
      enterRoom(nickname: $nickName, avatar: $avatar, lang: $language, code: $code) {
        __typename
        userId
        roomId
        token
      }
    }
    """

  public let operationName: String = "EnterRoom"

  public var nickName: String
  public var avatar: String
  public var language: String
  public var code: String

  public init(nickName: String, avatar: String, language: String, code: String) {
    self.nickName = nickName
    self.avatar = avatar
    self.language = language
    self.code = code
  }

  public var variables: GraphQLMap? {
    return ["nickName": nickName, "avatar": avatar, "language": language, "code": code]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("enterRoom", arguments: ["nickname": GraphQLVariable("nickName"), "avatar": GraphQLVariable("avatar"), "lang": GraphQLVariable("language"), "code": GraphQLVariable("code")], type: .nonNull(.object(EnterRoom.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(enterRoom: EnterRoom) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "enterRoom": enterRoom.resultMap])
    }

    public var enterRoom: EnterRoom {
      get {
        return EnterRoom(unsafeResultMap: resultMap["enterRoom"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "enterRoom")
      }
    }

    public struct EnterRoom: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["enterRoomResponse"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("userId", type: .nonNull(.scalar(Int.self))),
          GraphQLField("roomId", type: .nonNull(.scalar(Int.self))),
          GraphQLField("token", type: .nonNull(.scalar(String.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(userId: Int, roomId: Int, token: String) {
        self.init(unsafeResultMap: ["__typename": "enterRoomResponse", "userId": userId, "roomId": roomId, "token": token])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var userId: Int {
        get {
          return resultMap["userId"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "userId")
        }
      }

      public var roomId: Int {
        get {
          return resultMap["roomId"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "roomId")
        }
      }

      public var token: String {
        get {
          return resultMap["token"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "token")
        }
      }
    }
  }
}

public final class FindRoomByIdQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query FindRoomById($roomID: Int!) {
      roomById(id: $roomID) {
        __typename
        code
        users {
          __typename
          id
          nickname
          avatar
          lang
          isDeleted
        }
      }
    }
    """

  public let operationName: String = "FindRoomById"

  public var roomID: Int

  public init(roomID: Int) {
    self.roomID = roomID
  }

  public var variables: GraphQLMap? {
    return ["roomID": roomID]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("roomById", arguments: ["id": GraphQLVariable("roomID")], type: .object(RoomById.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(roomById: RoomById? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "roomById": roomById.flatMap { (value: RoomById) -> ResultMap in value.resultMap }])
    }

    public var roomById: RoomById? {
      get {
        return (resultMap["roomById"] as? ResultMap).flatMap { RoomById(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "roomById")
      }
    }

    public struct RoomById: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Room"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("code", type: .nonNull(.scalar(String.self))),
          GraphQLField("users", type: .nonNull(.list(.nonNull(.object(User.selections))))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(code: String, users: [User]) {
        self.init(unsafeResultMap: ["__typename": "Room", "code": code, "users": users.map { (value: User) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var code: String {
        get {
          return resultMap["code"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "code")
        }
      }

      public var users: [User] {
        get {
          return (resultMap["users"] as! [ResultMap]).map { (value: ResultMap) -> User in User(unsafeResultMap: value) }
        }
        set {
          resultMap.updateValue(newValue.map { (value: User) -> ResultMap in value.resultMap }, forKey: "users")
        }
      }

      public struct User: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["User"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(Int.self))),
            GraphQLField("nickname", type: .nonNull(.scalar(String.self))),
            GraphQLField("avatar", type: .nonNull(.scalar(String.self))),
            GraphQLField("lang", type: .nonNull(.scalar(String.self))),
            GraphQLField("isDeleted", type: .nonNull(.scalar(Bool.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: Int, nickname: String, avatar: String, lang: String, isDeleted: Bool) {
          self.init(unsafeResultMap: ["__typename": "User", "id": id, "nickname": nickname, "avatar": avatar, "lang": lang, "isDeleted": isDeleted])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: Int {
          get {
            return resultMap["id"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var nickname: String {
          get {
            return resultMap["nickname"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "nickname")
          }
        }

        public var avatar: String {
          get {
            return resultMap["avatar"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "avatar")
          }
        }

        public var lang: String {
          get {
            return resultMap["lang"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "lang")
          }
        }

        public var isDeleted: Bool {
          get {
            return resultMap["isDeleted"]! as! Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "isDeleted")
          }
        }
      }
    }
  }
}

public final class GetMessageSubscription: GraphQLSubscription {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    subscription GetMessage {
      newMessage {
        __typename
        id
        text
        source
        createdAt
        user {
          __typename
          id
          nickname
          avatar
          lang
        }
      }
    }
    """

  public let operationName: String = "GetMessage"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Subscription"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("newMessage", type: .object(NewMessage.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(newMessage: NewMessage? = nil) {
      self.init(unsafeResultMap: ["__typename": "Subscription", "newMessage": newMessage.flatMap { (value: NewMessage) -> ResultMap in value.resultMap }])
    }

    public var newMessage: NewMessage? {
      get {
        return (resultMap["newMessage"] as? ResultMap).flatMap { NewMessage(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "newMessage")
      }
    }

    public struct NewMessage: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Message"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(Int.self))),
          GraphQLField("text", type: .nonNull(.scalar(String.self))),
          GraphQLField("source", type: .nonNull(.scalar(String.self))),
          GraphQLField("createdAt", type: .scalar(String.self)),
          GraphQLField("user", type: .nonNull(.object(User.selections))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: Int, text: String, source: String, createdAt: String? = nil, user: User) {
        self.init(unsafeResultMap: ["__typename": "Message", "id": id, "text": text, "source": source, "createdAt": createdAt, "user": user.resultMap])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: Int {
        get {
          return resultMap["id"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var text: String {
        get {
          return resultMap["text"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "text")
        }
      }

      public var source: String {
        get {
          return resultMap["source"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "source")
        }
      }

      public var createdAt: String? {
        get {
          return resultMap["createdAt"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "createdAt")
        }
      }

      public var user: User {
        get {
          return User(unsafeResultMap: resultMap["user"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "user")
        }
      }

      public struct User: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["User"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(Int.self))),
            GraphQLField("nickname", type: .nonNull(.scalar(String.self))),
            GraphQLField("avatar", type: .nonNull(.scalar(String.self))),
            GraphQLField("lang", type: .nonNull(.scalar(String.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: Int, nickname: String, avatar: String, lang: String) {
          self.init(unsafeResultMap: ["__typename": "User", "id": id, "nickname": nickname, "avatar": avatar, "lang": lang])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: Int {
          get {
            return resultMap["id"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var nickname: String {
          get {
            return resultMap["nickname"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "nickname")
          }
        }

        public var avatar: String {
          get {
            return resultMap["avatar"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "avatar")
          }
        }

        public var lang: String {
          get {
            return resultMap["lang"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "lang")
          }
        }
      }
    }
  }
}

public final class GetMessageByTimeQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetMessageByTime($timeStamp: String!) {
      allMessagesByTime(time: $timeStamp) {
        __typename
        id
        text
        source
        createdAt
        user {
          __typename
          id
          nickname
          avatar
          lang
        }
      }
    }
    """

  public let operationName: String = "GetMessageByTime"

  public var timeStamp: String

  public init(timeStamp: String) {
    self.timeStamp = timeStamp
  }

  public var variables: GraphQLMap? {
    return ["timeStamp": timeStamp]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("allMessagesByTime", arguments: ["time": GraphQLVariable("timeStamp")], type: .list(.object(AllMessagesByTime.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(allMessagesByTime: [AllMessagesByTime?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "allMessagesByTime": allMessagesByTime.flatMap { (value: [AllMessagesByTime?]) -> [ResultMap?] in value.map { (value: AllMessagesByTime?) -> ResultMap? in value.flatMap { (value: AllMessagesByTime) -> ResultMap in value.resultMap } } }])
    }

    public var allMessagesByTime: [AllMessagesByTime?]? {
      get {
        return (resultMap["allMessagesByTime"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [AllMessagesByTime?] in value.map { (value: ResultMap?) -> AllMessagesByTime? in value.flatMap { (value: ResultMap) -> AllMessagesByTime in AllMessagesByTime(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [AllMessagesByTime?]) -> [ResultMap?] in value.map { (value: AllMessagesByTime?) -> ResultMap? in value.flatMap { (value: AllMessagesByTime) -> ResultMap in value.resultMap } } }, forKey: "allMessagesByTime")
      }
    }

    public struct AllMessagesByTime: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Message"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(Int.self))),
          GraphQLField("text", type: .nonNull(.scalar(String.self))),
          GraphQLField("source", type: .nonNull(.scalar(String.self))),
          GraphQLField("createdAt", type: .scalar(String.self)),
          GraphQLField("user", type: .nonNull(.object(User.selections))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: Int, text: String, source: String, createdAt: String? = nil, user: User) {
        self.init(unsafeResultMap: ["__typename": "Message", "id": id, "text": text, "source": source, "createdAt": createdAt, "user": user.resultMap])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: Int {
        get {
          return resultMap["id"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var text: String {
        get {
          return resultMap["text"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "text")
        }
      }

      public var source: String {
        get {
          return resultMap["source"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "source")
        }
      }

      public var createdAt: String? {
        get {
          return resultMap["createdAt"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "createdAt")
        }
      }

      public var user: User {
        get {
          return User(unsafeResultMap: resultMap["user"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "user")
        }
      }

      public struct User: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["User"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(Int.self))),
            GraphQLField("nickname", type: .nonNull(.scalar(String.self))),
            GraphQLField("avatar", type: .nonNull(.scalar(String.self))),
            GraphQLField("lang", type: .nonNull(.scalar(String.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: Int, nickname: String, avatar: String, lang: String) {
          self.init(unsafeResultMap: ["__typename": "User", "id": id, "nickname": nickname, "avatar": avatar, "lang": lang])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: Int {
          get {
            return resultMap["id"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var nickname: String {
          get {
            return resultMap["nickname"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "nickname")
          }
        }

        public var avatar: String {
          get {
            return resultMap["avatar"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "avatar")
          }
        }

        public var lang: String {
          get {
            return resultMap["lang"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "lang")
          }
        }
      }
    }
  }
}

public final class LeaveRoomMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation LeaveRoom {
      deleteUser
    }
    """

  public let operationName: String = "LeaveRoom"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("deleteUser", type: .nonNull(.scalar(Bool.self))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(deleteUser: Bool) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "deleteUser": deleteUser])
    }

    public var deleteUser: Bool {
      get {
        return resultMap["deleteUser"]! as! Bool
      }
      set {
        resultMap.updateValue(newValue, forKey: "deleteUser")
      }
    }
  }
}

public final class SendMessageMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation SendMessage($text: String!) {
      createMessage(text: $text)
    }
    """

  public let operationName: String = "SendMessage"

  public var text: String

  public init(text: String) {
    self.text = text
  }

  public var variables: GraphQLMap? {
    return ["text": text]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("createMessage", arguments: ["text": GraphQLVariable("text")], type: .nonNull(.scalar(Bool.self))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(createMessage: Bool) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "createMessage": createMessage])
    }

    public var createMessage: Bool {
      get {
        return resultMap["createMessage"]! as! Bool
      }
      set {
        resultMap.updateValue(newValue, forKey: "createMessage")
      }
    }
  }
}

public final class SendSystemMessageMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation SendSystemMessage($type: String!) {
      createSystemMessage(source: $type)
    }
    """

  public let operationName: String = "SendSystemMessage"

  public var type: String

  public init(type: String) {
    self.type = type
  }

  public var variables: GraphQLMap? {
    return ["type": type]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("createSystemMessage", arguments: ["source": GraphQLVariable("type")], type: .scalar(Bool.self)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(createSystemMessage: Bool? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "createSystemMessage": createSystemMessage])
    }

    public var createSystemMessage: Bool? {
      get {
        return resultMap["createSystemMessage"] as? Bool
      }
      set {
        resultMap.updateValue(newValue, forKey: "createSystemMessage")
      }
    }
  }
}

public final class TranslationMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation Translation($text: String!) {
      translation(text: $text) {
        __typename
        translatedText
      }
    }
    """

  public let operationName: String = "Translation"

  public var text: String

  public init(text: String) {
    self.text = text
  }

  public var variables: GraphQLMap? {
    return ["text": text]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("translation", arguments: ["text": GraphQLVariable("text")], type: .nonNull(.object(Translation.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(translation: Translation) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "translation": translation.resultMap])
    }

    public var translation: Translation {
      get {
        return Translation(unsafeResultMap: resultMap["translation"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "translation")
      }
    }

    public struct Translation: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["translationResponse"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("translatedText", type: .nonNull(.scalar(String.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(translatedText: String) {
        self.init(unsafeResultMap: ["__typename": "translationResponse", "translatedText": translatedText])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var translatedText: String {
        get {
          return resultMap["translatedText"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "translatedText")
        }
      }
    }
  }
}

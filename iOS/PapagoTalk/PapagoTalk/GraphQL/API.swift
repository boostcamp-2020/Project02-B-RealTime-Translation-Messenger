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
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(userId: Int, roomId: Int, code: String) {
        self.init(unsafeResultMap: ["__typename": "createRoomResponse", "userId": userId, "roomId": roomId, "code": code])
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
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(userId: Int, roomId: Int) {
        self.init(unsafeResultMap: ["__typename": "enterRoomResponse", "userId": userId, "roomId": roomId])
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

public final class GetMessageSubscription: GraphQLSubscription {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    subscription GetMessage($roomId: Int!, $language: String!) {
      newMessage(roomId: $roomId, lang: $language) {
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

  public var roomId: Int
  public var language: String

  public init(roomId: Int, language: String) {
    self.roomId = roomId
    self.language = language
  }

  public var variables: GraphQLMap? {
    return ["roomId": roomId, "language": language]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Subscription"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("newMessage", arguments: ["roomId": GraphQLVariable("roomId"), "lang": GraphQLVariable("language")], type: .object(NewMessage.selections)),
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

public final class SendMessageMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation SendMessage($text: String!, $source: String!, $userId: Int!, $roomId: Int!) {
      createMessage(text: $text, source: $source, userId: $userId, roomId: $roomId)
    }
    """

  public let operationName: String = "SendMessage"

  public var text: String
  public var source: String
  public var userId: Int
  public var roomId: Int

  public init(text: String, source: String, userId: Int, roomId: Int) {
    self.text = text
    self.source = source
    self.userId = userId
    self.roomId = roomId
  }

  public var variables: GraphQLMap? {
    return ["text": text, "source": source, "userId": userId, "roomId": roomId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("createMessage", arguments: ["text": GraphQLVariable("text"), "source": GraphQLVariable("source"), "userId": GraphQLVariable("userId"), "roomId": GraphQLVariable("roomId")], type: .nonNull(.scalar(Bool.self))),
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

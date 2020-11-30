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

public final class GetMessageSubscription: GraphQLSubscription {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    subscription GetMessage($roomId: Int!) {
      newMessage(roomId: $roomId) {
        __typename
        id
        text
        source
        user {
          __typename
          id
          nickname
          avatar
        }
      }
    }
    """

  public let operationName: String = "GetMessage"

  public var roomId: Int

  public init(roomId: Int) {
    self.roomId = roomId
  }

  public var variables: GraphQLMap? {
    return ["roomId": roomId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Subscription"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("newMessage", arguments: ["roomId": GraphQLVariable("roomId")], type: .object(NewMessage.selections)),
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
          GraphQLField("user", type: .nonNull(.object(User.selections))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: Int, text: String, source: String, user: User) {
        self.init(unsafeResultMap: ["__typename": "Message", "id": id, "text": text, "source": source, "user": user.resultMap])
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
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: Int, nickname: String, avatar: String) {
          self.init(unsafeResultMap: ["__typename": "User", "id": id, "nickname": nickname, "avatar": avatar])
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

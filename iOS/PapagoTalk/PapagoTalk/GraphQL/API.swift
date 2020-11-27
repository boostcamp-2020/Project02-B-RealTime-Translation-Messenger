// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

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

// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class AllPairsDayQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query AllPairsDay {
      pairDayDatas(orderBy: dailyVolumeUSD, orderDirection: desc) {
        __typename
        token0 {
          __typename
          symbol
        }
        token1 {
          __typename
          symbol
        }
        dailyVolumeUSD
      }
    }
    """

  public let operationName: String = "AllPairsDay"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("pairDayDatas", arguments: ["orderBy": "dailyVolumeUSD", "orderDirection": "desc"], type: .nonNull(.list(.nonNull(.object(PairDayData.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(pairDayDatas: [PairDayData]) {
      self.init(unsafeResultMap: ["__typename": "Query", "pairDayDatas": pairDayDatas.map { (value: PairDayData) -> ResultMap in value.resultMap }])
    }

    public var pairDayDatas: [PairDayData] {
      get {
        return (resultMap["pairDayDatas"] as! [ResultMap]).map { (value: ResultMap) -> PairDayData in PairDayData(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: PairDayData) -> ResultMap in value.resultMap }, forKey: "pairDayDatas")
      }
    }

    public struct PairDayData: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["PairDayData"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("token0", type: .nonNull(.object(Token0.selections))),
          GraphQLField("token1", type: .nonNull(.object(Token1.selections))),
          GraphQLField("dailyVolumeUSD", type: .nonNull(.scalar(String.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(token0: Token0, token1: Token1, dailyVolumeUsd: String) {
        self.init(unsafeResultMap: ["__typename": "PairDayData", "token0": token0.resultMap, "token1": token1.resultMap, "dailyVolumeUSD": dailyVolumeUsd])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var token0: Token0 {
        get {
          return Token0(unsafeResultMap: resultMap["token0"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "token0")
        }
      }

      public var token1: Token1 {
        get {
          return Token1(unsafeResultMap: resultMap["token1"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "token1")
        }
      }

      public var dailyVolumeUsd: String {
        get {
          return resultMap["dailyVolumeUSD"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "dailyVolumeUSD")
        }
      }

      public struct Token0: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Token"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("symbol", type: .nonNull(.scalar(String.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(symbol: String) {
          self.init(unsafeResultMap: ["__typename": "Token", "symbol": symbol])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var symbol: String {
          get {
            return resultMap["symbol"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "symbol")
          }
        }
      }

      public struct Token1: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Token"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("symbol", type: .nonNull(.scalar(String.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(symbol: String) {
          self.init(unsafeResultMap: ["__typename": "Token", "symbol": symbol])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var symbol: String {
          get {
            return resultMap["symbol"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "symbol")
          }
        }
      }
    }
  }
}

public final class AllPairsHourlyQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query AllPairsHourly {
      pairHourDatas(orderBy: hourlyVolumeUSD, orderDirection: desc) {
        __typename
        pair {
          __typename
          token0 {
            __typename
            symbol
          }
          token1 {
            __typename
            symbol
          }
        }
        hourlyVolumeUSD
      }
    }
    """

  public let operationName: String = "AllPairsHourly"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("pairHourDatas", arguments: ["orderBy": "hourlyVolumeUSD", "orderDirection": "desc"], type: .nonNull(.list(.nonNull(.object(PairHourData.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(pairHourDatas: [PairHourData]) {
      self.init(unsafeResultMap: ["__typename": "Query", "pairHourDatas": pairHourDatas.map { (value: PairHourData) -> ResultMap in value.resultMap }])
    }

    public var pairHourDatas: [PairHourData] {
      get {
        return (resultMap["pairHourDatas"] as! [ResultMap]).map { (value: ResultMap) -> PairHourData in PairHourData(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: PairHourData) -> ResultMap in value.resultMap }, forKey: "pairHourDatas")
      }
    }

    public struct PairHourData: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["PairHourData"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("pair", type: .nonNull(.object(Pair.selections))),
          GraphQLField("hourlyVolumeUSD", type: .nonNull(.scalar(String.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(pair: Pair, hourlyVolumeUsd: String) {
        self.init(unsafeResultMap: ["__typename": "PairHourData", "pair": pair.resultMap, "hourlyVolumeUSD": hourlyVolumeUsd])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var pair: Pair {
        get {
          return Pair(unsafeResultMap: resultMap["pair"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "pair")
        }
      }

      public var hourlyVolumeUsd: String {
        get {
          return resultMap["hourlyVolumeUSD"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "hourlyVolumeUSD")
        }
      }

      public struct Pair: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Pair"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("token0", type: .nonNull(.object(Token0.selections))),
            GraphQLField("token1", type: .nonNull(.object(Token1.selections))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(token0: Token0, token1: Token1) {
          self.init(unsafeResultMap: ["__typename": "Pair", "token0": token0.resultMap, "token1": token1.resultMap])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var token0: Token0 {
          get {
            return Token0(unsafeResultMap: resultMap["token0"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "token0")
          }
        }

        public var token1: Token1 {
          get {
            return Token1(unsafeResultMap: resultMap["token1"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "token1")
          }
        }

        public struct Token0: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Token"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("symbol", type: .nonNull(.scalar(String.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(symbol: String) {
            self.init(unsafeResultMap: ["__typename": "Token", "symbol": symbol])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var symbol: String {
            get {
              return resultMap["symbol"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "symbol")
            }
          }
        }

        public struct Token1: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Token"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("symbol", type: .nonNull(.scalar(String.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(symbol: String) {
            self.init(unsafeResultMap: ["__typename": "Token", "symbol": symbol])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var symbol: String {
            get {
              return resultMap["symbol"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "symbol")
            }
          }
        }
      }
    }
  }
}

public final class AllTokensQueryQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query AllTokensQuery {
      pairs(orderBy: volumeUSD, orderDirection: desc) {
        __typename
        token0 {
          __typename
          symbol
        }
        token1 {
          __typename
          symbol
        }
        volumeUSD
      }
    }
    """

  public let operationName: String = "AllTokensQuery"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("pairs", arguments: ["orderBy": "volumeUSD", "orderDirection": "desc"], type: .nonNull(.list(.nonNull(.object(Pair.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(pairs: [Pair]) {
      self.init(unsafeResultMap: ["__typename": "Query", "pairs": pairs.map { (value: Pair) -> ResultMap in value.resultMap }])
    }

    public var pairs: [Pair] {
      get {
        return (resultMap["pairs"] as! [ResultMap]).map { (value: ResultMap) -> Pair in Pair(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: Pair) -> ResultMap in value.resultMap }, forKey: "pairs")
      }
    }

    public struct Pair: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Pair"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("token0", type: .nonNull(.object(Token0.selections))),
          GraphQLField("token1", type: .nonNull(.object(Token1.selections))),
          GraphQLField("volumeUSD", type: .nonNull(.scalar(String.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(token0: Token0, token1: Token1, volumeUsd: String) {
        self.init(unsafeResultMap: ["__typename": "Pair", "token0": token0.resultMap, "token1": token1.resultMap, "volumeUSD": volumeUsd])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var token0: Token0 {
        get {
          return Token0(unsafeResultMap: resultMap["token0"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "token0")
        }
      }

      public var token1: Token1 {
        get {
          return Token1(unsafeResultMap: resultMap["token1"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "token1")
        }
      }

      public var volumeUsd: String {
        get {
          return resultMap["volumeUSD"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "volumeUSD")
        }
      }

      public struct Token0: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Token"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("symbol", type: .nonNull(.scalar(String.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(symbol: String) {
          self.init(unsafeResultMap: ["__typename": "Token", "symbol": symbol])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var symbol: String {
          get {
            return resultMap["symbol"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "symbol")
          }
        }
      }

      public struct Token1: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Token"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("symbol", type: .nonNull(.scalar(String.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(symbol: String) {
          self.init(unsafeResultMap: ["__typename": "Token", "symbol": symbol])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var symbol: String {
          get {
            return resultMap["symbol"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "symbol")
          }
        }
      }
    }
  }
}

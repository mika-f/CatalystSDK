// https://stackoverflow.com/a/46049763
// https://gist.github.com/loudmouth/332e8d89d8de2c1eaf81875cfcd22e24
// https://qiita.com/takehilo/items/23a68c57448e589f3ea8
//
// Licensed under the CC-BY-SA 4.0 License
//
struct JSONCodingKeys: CodingKey {
  var stringValue: String

  init?(stringValue: String) {
    self.stringValue = stringValue
  }

  var intValue: Int?

  init?(intValue: Int) {
    self.init(stringValue: "\(intValue)")
    self.intValue = intValue
  }
}

extension KeyedDecodingContainer {
  func decode(_ type: [Any].Type, forKey key: K) throws -> [Any] {
    var container = try nestedUnkeyedContainer(forKey: key)
    return try container.decode(type)
  }

  func decodeIfPresent(_ type: [Any].Type, forKey key: K) throws -> [Any]? {
    guard contains(key) else {
      return nil
    }
    return try decode(type, forKey: key)
  }

  func decode(_ type: [String: Any].Type, forKey key: K) throws -> [String: Any] {
    let container = try nestedContainer(keyedBy: JSONCodingKeys.self, forKey: key)
    return try container.decode(type)
  }

  func decodeIfPresent(_ type: [String: Any].Type, forKey key: K) throws -> [String: Any]? {
    guard contains(key) else {
      return nil
    }
    return try decode(type, forKey: key)
  }

  func decode(_: [String: Any].Type) throws -> [String: Any] {
    var dictionary = [String: Any]()

    for key in allKeys {
      if let boolValue = try? decode(Bool.self, forKey: key) {
        dictionary[key.stringValue] = boolValue
      } else if let stringValue = try? decode(String.self, forKey: key) {
        dictionary[key.stringValue] = stringValue
      } else if let intValue = try? decode(Int.self, forKey: key) {
        dictionary[key.stringValue] = intValue
      } else if let doubleValue = try? decode(Double.self, forKey: key) {
        dictionary[key.stringValue] = doubleValue
      } else if let nestedDictionary = try? decode([String: Any].self, forKey: key) {
        dictionary[key.stringValue] = nestedDictionary
      } else if let nestedArray = try? decode([Any].self, forKey: key) {
        dictionary[key.stringValue] = nestedArray
      }
    }
    return dictionary
  }
}

extension UnkeyedDecodingContainer {
  mutating func decode(_: [Any].Type) throws -> [Any] {
    var array: [Any] = []
    while isAtEnd == false {
      if let value = try? decode(Bool.self) {
        array.append(value)
      } else if let value = try? decode(Double.self) {
        array.append(value)
      } else if let value = try? decode(String.self) {
        array.append(value)
      } else if let nestedDictionary = try? decode([String: Any].self) {
        array.append(nestedDictionary)
      } else if let nestedArray = try? decode([Any].self) {
        array.append(nestedArray)
      }
    }
    return array
  }

  mutating func decode(_ type: [String: Any].Type) throws -> [String: Any] {
    let nestedContainer = try nestedContainer(keyedBy: JSONCodingKeys.self)
    return try nestedContainer.decode(type)
  }
}

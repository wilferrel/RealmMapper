//
//  Realm+ObjectMapper.swift
//  RealmMapper
//
//  Created by DaoNV on 3/13/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import RealmSwift
import ObjectMapper

// MARK: - TRANFORM
// MARK: Object
class ObjectTransform<T:RealmSwift.Object where T:Mappable> : TransformType {
  typealias Object = T
  typealias JSON = AnyObject
  
  let mapper = Mapper<T>()
  
  func transformFromJSON(value: AnyObject?) -> Object? {
    if let json = value as? [String : AnyObject], obj = mapper.map(json) {
      return obj
    }
    return nil
  }
  
  func transformToJSON(value: Object?) -> JSON? {
    if let obj = value {
      return mapper.toJSON(obj)
    } else {
      return NSNull()
    }
  }
}

// MARK: List
class ListTransform<T:RealmSwift.Object where T:Mappable> : TransformType {
  typealias Object = List<T>
  typealias JSON = AnyObject
  
  let mapper = Mapper<T>()
  
  func transformFromJSON(value: AnyObject?) -> Object? {
    let results = Object()
    if let jsArray = value as? [AnyObject] {
      for json in jsArray {
        if let obj = mapper.map(json) {
          results.append(obj)
        }
      }
    }
    return results
  }
  
  func transformToJSON(value: Object?) -> JSON? {
    if let value = value {
      var results = [AnyObject]()
      for obj in value {
        let json = mapper.toJSON(obj)
        results.append(json)
      }
      return results
    } else {
      return NSNull()
    }
  }
}

// MARK: - MAPPING
// MARK: Optinal Object
public func <- <T: Object where T: Mappable>(inout left: T?, right: Map) throws {
  left <- (right, ObjectTransform<T>())
}

// MARK: Implicitly Unwrapped Optional Object
public func <- <T: Object where T: Mappable>(inout left: T!, right: Map) {
  left <- (right, ObjectTransform<T>())
}

// MARK: List
public func <- <T: Object where T: Mappable>(left: List<T>, right: Map) {
  if right.mappingType == MappingType.FromJSON {
    if let value = right.currentValue {
      left.removeAll()
      if let jsArray = value as? [[String : AnyObject]] {
        let mapper = Mapper<T>()
        for json in jsArray {
          if let json = mapper.map(json) {
            left.append(json)
          }
        }
      }
    }
  } else {
    var left_ = left
    left_ <- (right, ListTransform<T>())
  }
}

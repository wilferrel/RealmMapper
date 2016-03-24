//
//  Realm+ObjectMapper.swift
//  RealmMapper
//
//  Created by DaoNV on 3/13/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import RealmSwift
import ObjectMapper

// MARK: - Extensions
extension Realm {
  /*
   Remove store of default realm.
   */
  public class func reset() {
    if let storePath = Realm.Configuration.defaultConfiguration.path {
      do {
        try NSFileManager.defaultManager().removeItemAtPath(storePath)
      } catch {
        let error = error as NSError
        NSLog(error.localizedDescription)
      }
    }
  }

  /*
   Import object from json.

   - warning: This method can only be called during a write transaction.

   - parameter type:   The object type to create.
   - parameter json:   The value used to populate the object.
   */
  public func add<T: Object where T: Mappable>(type: T.Type, json: [String: AnyObject]) -> T? {
    if let obj = Mapper<T>().map(json) {
      add(obj, update: T.primaryKey() != nil)
      return obj
    }
    return nil
  }

  /*
   Import array from json.

   - warning: This method can only be called during a write transaction.

   - parameter type:   The object type to create.
   - parameter json:   The value used to populate the object.
   */
  public func add<T: Object where T: Mappable>(type: T.Type, json: [[String: AnyObject]]) -> [T]? {
    if let objs = Mapper<T>().mapArray(json) {
      add(objs, update: T.primaryKey() != nil)
      return objs
    }
    return nil
  }
}

// MARK: - Transform
public func <- <T: Object where T: Mappable>(left: List<T>, right: Map) {
  var objs: [T]?
  if right.mappingType == .FromJSON {
    if right.currentValue != nil {
      left.removeAll()
      objs <- right
      if let objs = objs {
        left.appendContentsOf(objs)
      }
    }
  } else {
    objs = left.map { $0 }
    objs <- right
  }
}

//
//  Realm.swift
//  RealmMapper
//
//  Created by DaoNV on 3/13/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import RealmSwift

extension Realm {
  class func reset() throws {
    if let storePath = Realm.Configuration.defaultConfiguration.path {
      try NSFileManager.defaultManager().removeItemAtPath(storePath)
    }
  }
}

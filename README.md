[![Build Status](https://travis-ci.org/zendobk/RealmMapper.svg?branch=master)](https://travis-ci.org/zendobk/RealmMapper)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/RealmMapper.svg)](https://img.shields.io/cocoapods/v/RealmMapper.svg)
[![Platform](https://img.shields.io/cocoapods/p/RealmMapper.svg?style=flat)](http://cocoadocs.org/docsets/RealmMapper)
[![Code Coverage](http://codecov.io/github/zendobk/RealmMapper/coverage.svg?branch=master)](http://codecov.io/github/zendobk/RealmMapper?branch=master)

[RealmMapper](https://github.com/zendobk/RealmMapper)
============

## Requirements

 - iOS 8.0+
 - Xcode 7.2+

## Installation
 
 > **Embedded frameworks require a minimum deployment target of iOS 8.**

### CocoaPods
 
[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:
 
```bash
$ gem install cocoapods
 ```
 
> CocoaPods 0.39.0+ is required to build RealmMapper 1.2+.
 
To integrate RealmMapper into your Xcode project using CocoaPods, specify it in your `Podfile`:
 
```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

pod 'RealmMapper', '~> 1.0.0'
```
 
Then, run the following command:
 
```bash
$ pod install
```

## Usage

### Mapping
```swift
import RealmSwift
import ObjectMapper
import RealmMapper
 
class User: Object, Mappable {
  dynamic var id: String!
  dynamic var name: String?
  dynamic var address: Address?
  let dogs = List<Dog>()

  override class func primaryKey() -> String? {
    return "id"
  }
  
  convenience required init?(_ map: Map) {
    self.init()
    id <- map["id"]
  }
 
  func mapping(map: Map) {
    name <- map["name"]
    address <- map["address"]
    dogs <- map["dogs"]    
  }
}
```
### Import JSON to Realm
```swift
do {
  let realm = Realm()
  try realm.write {
    realm.add(User.self, jsUser)
    realm.add(Shop.self, jsShops)
  }
} catch {  
}

```

> nil value will be bypass, if you want set `nil` please use `NSNull()` instead

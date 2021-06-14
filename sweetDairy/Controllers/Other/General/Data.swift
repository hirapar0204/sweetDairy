//
//  Data.swift
//  sweetDairy
//
//  Created by hirapar on 2021/06/04.
//

import Foundation
import RealmSwift

class photoData: Object {
    @objc dynamic var id = 0
    @objc dynamic var menu: String?
    @objc dynamic var value: String?
    @objc dynamic var store: String?
    @objc dynamic var date: Date? 
    @objc dynamic var star: String?
    @objc dynamic var pngImage: NSData!
    
    open var primaryKey: String {
        return "id"
    }

}

class profileData: Object {
    @objc dynamic var id = 0
    @objc dynamic var name: String?
    @objc dynamic var pngImage: NSData!
    
    open var primaryKey: String {
        return "id"
    }

}

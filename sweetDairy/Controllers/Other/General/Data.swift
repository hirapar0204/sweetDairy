//
//  Data.swift
//  sweetDairy
//
//  Created by hirapar on 2021/06/04.
//

import UIKit
import RealmSwift

class Data: Object {
    @objc dynamic var id = 0
    @objc dynamic var menu: String?
    @objc dynamic var value: String?
    @objc dynamic var store: String?
    @objc dynamic var date: String?
    @objc dynamic var star: String?
    @objc dynamic var str: String?
    
    open var primaryKey: String {
        return "id"
    }

}

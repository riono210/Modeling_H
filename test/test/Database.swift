//
//  graphData.swift
//  test
//
//  Created by 内原　朝也 on 2018/01/25.
//  Copyright © 2018年 松下亮太. All rights reserved.
//

import Foundation
import RealmSwift

class incomeData : Object {
    @objc dynamic var year: Int = Int()
    @objc dynamic var month: Int = Int()
    @objc dynamic var day: Int = Int()
    @objc dynamic var data : Int = Int(0)
    @objc dynamic var label : String = String()
    @objc dynamic var Category : String = String()
    
    func save() {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(self)
            }
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
}

class expenceData : Object {
    @objc dynamic var year: Int = Int()
    @objc dynamic var month: Int = Int()
    @objc dynamic var day: Int = Int()
    @objc dynamic var data : Int = Int(0)
    @objc dynamic var label : String = String()
    @objc dynamic var Category : String = String()
    
    func save() {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(self)
            }
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
}

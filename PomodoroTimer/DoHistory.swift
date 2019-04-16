//
//  DoHistory.swift
//  PomodoroTimer
//
//  Created by matsumoto miharu on 2019/02/28.
//  Copyright © 2019年 ポモポモ. All rights reserved.
//

import RealmSwift

class DoHistory: Object {
    @objc dynamic var id : Int = 0;
    @objc dynamic var title = "";
    @objc dynamic var doTime = "";
    @objc dynamic var createdDate : Date = NSDate() as Date
    
    // データを保存。
    func save(title : String, doTime : String) {
        let realm = try! Realm()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        if realm.isInWriteTransaction {
            if self.id == 0 { self.id = self.createNewId() }
            self.title = title
            self.doTime = doTime
            realm.add(self, update: true)
        } else {
            try! realm.write {
                if self.id == 0 { self.id = self.createNewId() }
                self.title = title
                self.doTime = doTime
                realm.add(self, update: true)
            }
        }
    }
    
    // 新しいIDを採番します。
    private func createNewId() -> Int {
        let realm = try! Realm()
        return (realm.objects(type(of: self).self).sorted(byKeyPath: "id", ascending: false).first?.id ?? 0) + 1
    }
    
    // プライマリーキーの設定
    override static func primaryKey() -> String? {
        return "id"
    }

}

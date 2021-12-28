//
//  Realm.Configuration+Ext.swift
//  Swift_UI
//
//  Created by Mikhail Chudaev on 12.12.2021.
//

import RealmSwift

extension Realm.Configuration {
    static let deleteIfMigration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
}

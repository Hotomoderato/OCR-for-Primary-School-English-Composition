//
//  EntryViewController.swift
//  LoTsProject
//
//  Created by lots on 2021/2/26.
//
//

import UIKit

@objcMembers
class LPUser: SQLiteModel { // 用户模型

    var account   : String = ""
    var score  : String = ""
    var text : String = ""
    
    override func primaryKey() -> String {
        return "account"
    }
    
}

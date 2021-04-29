//
//  AppDelegate.swift
//  LoTsProject
//
//  Created by lots on 2021/2/26.
//

import UIKit

public let ScreenWidth: CGFloat = UIScreen.main.bounds.size.width
public let ScreenHeight: CGFloat = UIScreen.main.bounds.size.height

// MARK: - 全局公用属性
public let kNaviBarH: CGFloat = 44
public let KTabbarH: CGFloat = 49
public let KNavH: CGFloat = ScreenHeight > 800 ? 88 : 64
public let KBottomH: CGFloat = ScreenHeight > 800 ? KTabbarH + 34: KTabbarH
public let TopCons: CGFloat = ScreenHeight > 800  ? 100 : 80



@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    
    let SqlTableUser = "LPUser"

    /// 初始化数据库封装类
    var operateType: SQLiteOperateType = .statement{
        didSet{
            SQLiteDataBase.shared.operateType = self.operateType
        }
    }
    
    lazy var manager: SQLiteDataBase = {
        var dataName = "wrapperDB"
        if operateType == .statement {
            dataName = "statementDB"
        }
        return SQLiteDataBase.createDB(dataName)
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setUpDefault()
        
        return true
    }
    
    
    func setUpDefault() {
        
        let defaultModel1 = LPUser()
        defaultModel1.account = "测试账户1"
        defaultModel1.score = "99.1"
        defaultModel1.text = "Nothing tastes better than tangyuan on Lantern Festival."
        
        let defaultModel2 = LPUser()
        defaultModel2.account = "测试账户2"
        defaultModel2.score = "90.1"
        defaultModel2.text = "The 1896 Cedar Keys hurricane was a powerful tropical cyclone that devastated much of the East Coast of the United States, starting with Florida's Cedar Keys, near the end of September. "
        
        AppDelegate().manager.insert(defaultModel1 , intoTable: AppDelegate().SqlTableUser)
        AppDelegate().manager.insert(defaultModel2 , intoTable: AppDelegate().SqlTableUser)
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}


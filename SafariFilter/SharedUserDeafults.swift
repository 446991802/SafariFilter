//
//  SharedUserDeafults.swift
//  SafariFilter
//
//  Created by 吴非 on 2021/9/29.
//

import UIKit


struct  SharedUserDeafults {
    
    static let suiteName = Constants.appGroupIdentifier
    
    struct Keys {
        
        // 功能是否启用
        static let isEnableState   = "onEnableState"      // 页面是否开启 & 关闭
        // 是否开启广告拦截
        static let isBlockerState       = "onBlockerState"          // 配置是否过滤 & 清零
        // 是否拦截跳转APP
        static let isSkipAppState       = "onSkipAppState"          // 跳转应用过滤 & 清零
        

    }
}


extension SharedUserDeafults {
    
    // 查询
    static func query(kw: String) -> Bool {
        return UserDefaults(suiteName: suiteName)?.bool(forKey: kw) ?? false
    }
    
    // 写入
    static func replace(kw: String, isValue: Bool) {
        guard let sdm = UserDefaults(suiteName: suiteName)  else { return }
        sdm.set(isValue, forKey: kw)
        sdm.synchronize()
    }
}

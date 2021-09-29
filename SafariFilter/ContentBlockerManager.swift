//
//  ContentBlockerManager.swift
//  SafariFilter
//
//  Created by 吴非 on 2021/9/29.
//

import UIKit
import SafariServices

class ContentBlockerManager: NSObject {
    
    static let identifier_aa: String = "com.zzq.safari.Interceptor"
    static let identifier_bb: String = "com.zzq.safari.Blocker"
    
    private override init() {}
    static let `default` = ContentBlockerManager()
    
    
    func isPermissions(identifier: String) -> Bool {
        var contentBlockerState: Bool?
        let semaphore = DispatchSemaphore(value: 0)
        SFContentBlockerManager.getStateOfContentBlocker(withIdentifier: identifier) { state, error in
            // 错误检查
            if let stateError = error {
                print("\(identifier)#\(stateError.localizedDescription as Any)")
                return
            }
            // 权限状态
            print("\(identifier)#\(state?.isEnabled as Any)")
            
            contentBlockerState = state?.isEnabled
            semaphore.signal()
        }
        semaphore.wait()
        return contentBlockerState ?? false
    }
    
    
    // 检查权限
    // - Parameters:
    //   - identifier: 扩展identifier
    //   - isUpdated: 是否直接更新
    func checkUpWith(identifier: String, isUpdate: Bool = true) {
        SFContentBlockerManager.getStateOfContentBlocker(withIdentifier: identifier) { (state, error) in
            guard let stateValue = state else { return }
            if stateValue.isEnabled {
                SFContentBlockerManager.reloadContentBlocker(withIdentifier: identifier) { (updateError) in
                    // 错误检查
                    if let stateError = updateError {
                        print("\(identifier)#\(stateError.localizedDescription as Any)")
                        return
                    }
                    print("\(identifier)#刷新配置成功")
                }
            }
        }
    }
    
    /// 更新所有配置
    func refreshAll() {
        
        [
            Constants.interceptorIdentifier,
            Constants.blockerIdentifier,
            
        ].forEach( { SFContentBlockerManager.reloadContentBlocker(withIdentifier: $0, completionHandler: nil)})
    }
}

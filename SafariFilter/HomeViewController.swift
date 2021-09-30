//
//  HomeViewController.swift
//  SafariFilter
//
//  Created by 吴非 on 2021/9/29.
//

import UIKit

class HomeViewController: UIViewController {
    
    // 全部配置
    @IBOutlet weak var isEnableSwitch: UISwitch!
    
    // 广告配置
    @IBOutlet weak var isAdvSwitch: UISwitch!
    
    // 跳转应用
    @IBOutlet weak var isJumpSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // 测试拦截 https://fanyi.baidu.com/
        isEnableSwitch.isOn = SharedUserDeafults.query(kw: SharedUserDeafults.Keys.isEnableState)
        isAdvSwitch.isOn    = SharedUserDeafults.query(kw: SharedUserDeafults.Keys.isBlockerState)
        isJumpSwitch.isOn   = SharedUserDeafults.query(kw: SharedUserDeafults.Keys.isSkipAppState)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    /// 拦截器
    /// - Parameter sender: 1000#广告 1001#跳转
    @IBAction func chanageInterceptor(_ sender: UISwitch) {
        print("\(sender.tag)#click")
        
        switch sender.tag {
        case 1000:
            SharedUserDeafults.replace(kw: SharedUserDeafults.Keys.isEnableState, isValue: sender.isOn)
            break
        case 1001:
            SharedUserDeafults.replace(kw: SharedUserDeafults.Keys.isBlockerState, isValue: sender.isOn)
            break
        case 1002:
            SharedUserDeafults.replace(kw: SharedUserDeafults.Keys.isSkipAppState, isValue: sender.isOn)
            break
        default:
            break
        }
        // 刷新
        ContentBlockerManager.default.refreshAll()
    }
}

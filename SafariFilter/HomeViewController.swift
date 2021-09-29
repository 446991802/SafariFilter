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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // 测试拦截 https://fanyi.baidu.com/
        
        isEnableSwitch.isOn = SharedUserDeafults.query(kw: SharedUserDeafults.Keys.isEnableState)
        isAdvSwitch.isOn    = SharedUserDeafults.query(kw: SharedUserDeafults.Keys.isBlockerState)
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
            ContentBlockerManager.default.refreshAll()
            break
        case 1001:
            SharedUserDeafults.replace(kw: SharedUserDeafults.Keys.isBlockerState, isValue: sender.isOn)
            ContentBlockerManager.default.checkUpWith(identifier: ContentBlockerManager.identifier_bb)
            break
        case 1002:

            break
        default:
            break
        }
    }
}
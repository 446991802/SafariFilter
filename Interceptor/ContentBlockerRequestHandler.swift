//
//  ContentBlockerRequestHandler.swift
//  Interceptor
//
//  Created by 吴非 on 2021/9/29.
//

import UIKit
import MobileCoreServices

class ContentBlockerRequestHandler: NSObject, NSExtensionRequestHandling {

    func beginRequest(with context: NSExtensionContext) {
        let sharedUserDeafults = UserDefaults(suiteName: SharedUserDeafults.suiteName)
        
        guard let mainOn = sharedUserDeafults?.bool(forKey: SharedUserDeafults.Keys.isEnableState) else { return }
        guard let adsBlockerOn = sharedUserDeafults?.bool(forKey: SharedUserDeafults.Keys.isSkipAppState) else { return }
        
        if mainOn {
            if adsBlockerOn {
                let attachment = NSItemProvider(contentsOf: Bundle.main.url(forResource: "blockerList", withExtension: "json"))!
                let item = NSExtensionItem()
                item.attachments = [attachment]
                context.completeRequest(returningItems: [item], completionHandler: nil)
            } else {
                let attachment = NSItemProvider(contentsOf: Bundle.main.url(forResource: "blockerListZero", withExtension: "json"))!
                let item = NSExtensionItem()
                item.attachments = [attachment]
                context.completeRequest(returningItems: [item], completionHandler: nil)
            }
        } else {
            let attachment = NSItemProvider(contentsOf: Bundle.main.url(forResource: "blockerListZero", withExtension: "json"))!
            let item = NSExtensionItem()
            item.attachments = [attachment]
            context.completeRequest(returningItems: [item], completionHandler: nil)
        }
    }
    
}

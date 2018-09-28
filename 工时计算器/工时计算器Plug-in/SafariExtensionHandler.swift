//
//  SafariExtensionHandler.swift
//  bbbbb
//
//  Created by youdone-dev on 2018/9/28.
//  Copyright © 2018年 youdone-dev. All rights reserved.
//

import SafariServices

class SafariExtensionHandler: SFSafariExtensionHandler {
    
    override func messageReceived(withName messageName: String, from page: SFSafariPage, userInfo: [String : Any]?) {
        // This method will be called when a content script provided by your extension calls safari.extension.dispatchMessage("message").
        page.getPropertiesWithCompletionHandler { properties in
            NSLog("The extension received a message (\(messageName)) from a script injected into (\(String(describing: properties?.url))) with userInfo (\(userInfo ?? [:]))")
        }
    }
    
    override func contextMenuItemSelected(withCommand command: String, in page: SFSafariPage, userInfo: [String : Any]? = nil) {
//        switch command {
//        case "Calculator":
//            let string: String? = userInfo?["selectedText"] as? String
//            if let content = string {
//                let title = JHWorkHoursCalculator.calculator(string: content)
//                page.dispatchMessageToScript(withName: "Calculator", userInfo: ["string":title])
//            }
//        default:
//            NSLog("default")
//        }
        
    }
    
    override func toolbarItemClicked(in window: SFSafariWindow) {
        // This method will be called when your toolbar item is clicked.
        NSLog("The extension's toolbar item was clicked")
    }
    
    override func validateToolbarItem(in window: SFSafariWindow, validationHandler: @escaping ((Bool, String) -> Void)) {
        // This is called when Safari's state changed in some way that would require the extension's toolbar item to be validated again.
//        validationHandler(true, "")
        validationHandler(true, "")
    }
    
    override func validateContextMenuItem(withCommand command: String, in page: SFSafariPage, userInfo: [String : Any]? = nil, validationHandler: @escaping (Bool, String?) -> Void) {
        let string: String? = userInfo?["selectedText"] as? String
        if let content = string {
            let title = JHWorkHoursCalculator.calculator(string: content)
            validationHandler(false, title)
        } else {
            validationHandler(true, nil)
        }
    }
    
    override func popoverViewController() -> SFSafariExtensionViewController {
        return SafariExtensionViewController.shared
    }
}

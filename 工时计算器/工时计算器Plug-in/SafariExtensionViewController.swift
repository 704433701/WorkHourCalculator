//
//  SafariExtensionViewController.swift
//  bbbbb
//
//  Created by youdone-dev on 2018/9/28.
//  Copyright © 2018年 youdone-dev. All rights reserved.
//

import SafariServices

class SafariExtensionViewController: SFSafariExtensionViewController, NSTextFieldDelegate {
    
    @IBOutlet weak var settingView: NSView!
    @IBOutlet weak var textField: NSTextField!
    @IBOutlet weak var settingTextField: NSTextField!
    @IBOutlet weak var resultLabel: NSTextField!
    @IBOutlet weak var noticeLabel: NSTextField!
    @IBOutlet weak var btnShowSetting: NSButton!
    @IBOutlet weak var warningLabel: NSTextField!
    @IBOutlet weak var settingViewHeight: NSLayoutConstraint!
    
    static let shared: SafariExtensionViewController = {
        let shared = SafariExtensionViewController()
//        shared.preferredContentSize = NSSize(width:200, height:240)
        return shared
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.settingViewHeight.constant = 0
        textField.delegate = self
        settingTextField.placeholderString = JHWorkHoursCalculator.getRest()
        updateRestLabel()
    }
    
    @IBAction func actionSetting(_ sender: NSButton) {
        settingViewHeight.animator().constant = sender.state == .off ? 0 : 90
    }
    
    func controlTextDidChange(_ obj: Notification) {
        let result = JHWorkHoursCalculator.calculator(string: textField.stringValue)
        resultLabel.stringValue = result
    }
    
    func updateRestLabel() {
        var restStr: String = JHWorkHoursCalculator.getRest()
        restStr = restStr.trimmingCharacters(in: .whitespaces)
        noticeLabel.stringValue = "午休时间\(restStr)不计入工时, 暂不支持跨天计算"
    }
    
    @IBAction func actionSave(_ sender: NSButton) {
        let result = JHWorkHoursCalculator.validateString(string: settingTextField.stringValue)
        if result.isTrue {
            JHWorkHoursCalculator.setRest(string: settingTextField.stringValue)
            updateRestLabel()
            btnShowSetting.state = .off
            warningLabel.stringValue = ""
            actionSetting(btnShowSetting)
        } else {
            warningLabel.stringValue = "格式不合法, 11:30-12:30"
        }
    }
}

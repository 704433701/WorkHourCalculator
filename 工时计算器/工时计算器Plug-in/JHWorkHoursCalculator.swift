//
//  JHC.swift
//  bbbbb
//
//  Created by youdone-dev on 2018/9/28.
//  Copyright © 2018年 youdone-dev. All rights reserved.
//

import Foundation

class JHWorkHoursCalculator {
    
    static func validateString(string: String) -> (isTrue: Bool, startTime: TimeInterval, endTime: TimeInterval) {
        let content = string.trimmingCharacters(in: .whitespaces)
        let list = content.components(separatedBy: CharacterSet(charactersIn: "-"))
        if list.count < 2 {
            return (false, 0, 0)
        }
        let startStr = "1970-02-01 \(list[0]):00"
        let endStr = "1970-02-01 \(list[1]):00"
        let startTime = stringConvertDate(string: startStr)
        let endTime = stringConvertDate(string: endStr)
        
        if startTime == 0 || endTime == 0 {
            return (false, 0, 0)
        }
        return (true, startTime, endTime)
    }
    
    static func calculator(string: String) -> String {
        let result = validateString(string: string)
        if !result.isTrue {
            return "时间区间无效, 无法计算"
        }
        
        let rest = validateString(string: getRest())
        var restStart: TimeInterval = 0.0
        var restEnd: TimeInterval = 0.0
        let start: TimeInterval = result.startTime
        let end: TimeInterval = result.endTime
        var workTime: TimeInterval = 0.0
        if rest.isTrue {
            restStart = rest.startTime
            restEnd = rest.endTime
        }
        let restTime = restEnd - restStart
        
        if start > restStart && start < restEnd {
            return "开始时间在休息时间内,无法计算"
        }
        
        if end > restStart && end < restEnd {
            return "结束时间在休息时间内,无法计算"
        }
        
        if start <= restStart && end >= restEnd {
            workTime = end - start - restTime
        } else {
            workTime = end - start
        }
        
        return "工时: \(workTime / 60.0 / 60.0)小时"
    }
    
    static func getRest() -> String {
        return (UserDefaults.standard.value(forKey: "JHRest") as? String) ?? "11:30-12:30"
    }
    
    static func setRest(string: String) {
        UserDefaults.standard.set(string, forKey: "JHRest")
    }
    
    static func stringConvertDate(string:String) -> TimeInterval {
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: string)
        return date?.timeIntervalSince1970 ?? 0
    }
}

//
//  ActivityViewModel.swift
//  NIU App
//
//  Created by Jacky Ben on 2023/8/27.
//

import Foundation
import Kanna

class ActivityViewModel {
    
    let userDefault = UserDefaults()
    let account: String
    let password: String
    
    // MARK: init
    init() {
        account = userDefault.value(forKey: "account") as! String
        password = userDefault.value(forKey: "password") as! String
    }
    
    // MARK: getInformation
    func getInformation() async -> [Activity] {
        var activitys: [Activity] = []
        
        let activityURL = URL(string: "https://syscc.niu.edu.tw/activity/")!
        var activityRequest = URLRequest(url: activityURL)
        activityRequest.allHTTPHeaderFields = headers
        do {
            let (activityPageData, _) = try await URLSession.shared.data(for: activityRequest)
            let activityPageHTML = String(decoding: activityPageData, as: UTF8.self)
            let doc = try? HTML(html: activityPageHTML, encoding: .utf8)
            let table = doc!.xpath("//tr")
            
            for rowIndex in 0...table.count {
                if (rowIndex == 0) {continue}
                if (rowIndex == table.count-1) {break}
                
                let row = table[rowIndex]
                activitys.append(Activity(node: row))
            }
        } catch {
            print("error")
        }
        activitys = activitys.sorted {
            if ($0.status == $1.status) {return $0.startDate < $1.startDate}
            else {
                switch ($0.status, $1.status) {
                case (.enable, .full): return true
                case (.enable, .expried): return true
                case (.enable, .unable): return true
                case (.full, .expried): return true
                case (.full, .unable): return true
                case (.unable, .expried): return true
                default: return false
                }
            }
        }

        return activitys
    }
}

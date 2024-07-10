//
//  SettingsViewModel.swift
//  Tradifundint
//
//  Created by Andrii Momot on 10.07.2024.
//

import Foundation
import UIKit.UIScene

extension SettingsView {
    final class SettingsViewModel: ObservableObject {
        var appLink = "https://apps.apple.com/ua/app/finance-expenses-and-income/id1521429599"
        @Published var isShareSheetPresented = false
        
        func setBatterySavingMode(isOn: Bool) {
            UIScreen.main.brightness = isOn ? 0.5 : 1
            UIScreen.main.wantsSoftwareDimming = isOn ? true : false
        }
        
        func openURL(_ urlString: String) {
            if let url = URL(string: urlString) {
                UIApplication.shared.open(url)
            }
        }
    }
}

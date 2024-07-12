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
        let appLink = "https://apps.apple.com/ua/app/finance-expenses-and-income/id1521429599"
        let supportURL = "https://support.tradifundint.info"
        
        @Published var isShareSheetPresented = false
        @Published var isAllowedNotifications = false
        
        func setBatterySavingMode(isOn: Bool) {
            UIScreen.main.brightness = isOn ? 0.5 : 1
            UIScreen.main.wantsSoftwareDimming = isOn ? true : false
        }
        
        func openURL(_ urlString: String) {
            if let url = URL(string: urlString) {
                UIApplication.shared.open(url)
            }
        }
        
        func openSettings() {
            if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                if UIApplication.shared.canOpenURL(appSettings) {
                    UIApplication.shared.open(appSettings)
                }
            }
        }
        
        func checkNotificationPermission() {
            UNUserNotificationCenter.current().getNotificationSettings { [weak self] settings in
                DispatchQueue.main.async {
                    let isAllowed = settings.authorizationStatus == .authorized
                    DefaultsService.isAllowedNotifications = isAllowed
                    self?.isAllowedNotifications = isAllowed
                }
            }
        }
    }
}

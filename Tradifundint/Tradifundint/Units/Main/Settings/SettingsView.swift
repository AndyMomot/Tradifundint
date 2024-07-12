//
//  SettingsView.swift
//  Tradifundint
//
//  Created by Andrii Momot on 10.07.2024.
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        ZStack {
            Colors.blueMidnight.swiftUIColor
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 40) {
                    Rectangle()
                        .foregroundStyle(.clear)
                        .cornerRadius(30, corners: [.bottomLeft])
                        .frame(height: bounds.height * 0.2)
                        .overlay {
                            DashedBorder(cornerRadius: 30)
                        }
                        .overlay {
                            HStack {
                                Text("Настройки")
                                    .foregroundStyle(.white)
                                    .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 30))
                                Spacer()
                            }
                            .padding(.top)
                            .padding(.horizontal)
                        }
                        .offset(x: 3, y: -6)
                    
                    VStack(spacing: 18) {
                        SettingCell(cellType: .notifications(isOn: viewModel.isAllowedNotifications)) { action in
                            switch action {
                            case .toggle(let isOn):
                                DefaultsService.isAllowedNotifications = isOn
                                if isOn {
                                    viewModel.openSettings()
                                }
                            case .link:
                                break
                            }
                        }
                        .frame(height: 63)
                        
                        SettingCell(cellType: .rateUs) { action in
                            switch action {
                            case .toggle:
                                break
                            case .link:
                                viewModel.openURL(viewModel.appLink)
                            }
                        }
                        .frame(height: 63)
                        
                        SettingCell(cellType: .saveEnergy) { action in
                            switch action {
                            case .toggle(let isOn):
                                DefaultsService.batterySaving = isOn
                                viewModel.setBatterySavingMode(isOn: isOn)
                            case .link:
                                break
                            }
                        }
                        .frame(height: 63)
                        
                        SettingCell(cellType: .share) { action in
                            switch action {
                            case .toggle:
                                break
                            case .link:
                                viewModel.isShareSheetPresented.toggle()
                            }
                        }
                        .frame(height: 63)
                    }
                }
            }
            .ignoresSafeArea(edges: .top)
            .sheet(isPresented: $viewModel.isShareSheetPresented) {
                ShareSheet(items: [viewModel.appLink])
            }
            .onAppear {
                viewModel.checkNotificationPermission()
            }
        }
    }
}

#Preview {
    SettingsView()
}

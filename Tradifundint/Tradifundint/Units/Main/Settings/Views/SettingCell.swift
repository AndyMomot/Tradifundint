//
//  SettingCell.swift
//  Tradifundint
//
//  Created by Andrii Momot on 10.07.2024.
//

import SwiftUI

struct SettingCell: View {
    var cellType: CellType
    var action: (ActionType) -> Void
    
    @State private var isOn = false
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .foregroundStyle(.clear)
            .overlay {
                HStack {
                    Text(cellType.title)
                        .foregroundStyle(.white)
                        .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 14))
                    
                    Spacer()
                    
                    switch cellType.actionType {
                    case .toggle:
                        Toggle("", isOn: $isOn)
                            .tint(Colors.firuza.swiftUIColor)
                            .labelsHidden()
                    case .link:
                        Button {
                            action(.link)
                        } label: {
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.white)
                        }
                    }
                }
                .padding(.horizontal)
            }
            .overlay {
                DashedBorder()
            }
            .onAppear {
                switch cellType.actionType {
                case .toggle(let bool):
                    isOn = bool
                case .link:
                    break
                }
            }
            .onChange(of: isOn) { value in
                action(.toggle(value))
            }
    }
}

extension SettingCell {
    enum CellType {
        case notifications(isOn: Bool)
        case rateUs
        case saveEnergy
        case share
        
        var title: String {
            switch self {
            case .notifications:
                return "Включить уведомления"
            case .rateUs:
                return "Оценить приложение"
            case .saveEnergy:
                return "Экономия батареи"
            case .share:
                return "Рассказать друзьям"
            }
        }
        
        var actionType: ActionType {
            switch self {
            case .notifications(let isOn):
                return .toggle(isOn)
            case .saveEnergy:
                return .toggle(DefaultsService.batterySaving)
            case .rateUs, .share:
                return .link
            }
        }
    }
    
    enum ActionType {
        case toggle(Bool)
        case link
    }
}

#Preview {
    ZStack {
        Colors.blueMidnight.swiftUIColor
        SettingCell(cellType: .share) { _ in
            
        }
    }
}

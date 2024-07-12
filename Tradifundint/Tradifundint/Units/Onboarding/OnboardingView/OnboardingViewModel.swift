//
//  OnboardingViewModel.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 12.06.2024.
//

import Foundation

extension OnboardingView {
    final class OnboardingViewModel: ObservableObject {
        @Published var showPrivacyPolicy = false
        let privacyPolicyURL = URL(string: "https://tradifundint.info")
    }
    
    enum OnboardingItem: Int, CaseIterable {
        case first = 0
        case second
        case third
        
        var imageName: String {
            switch self {
            case .first:
                return Asset.onboarding1.name
            case .second:
                return Asset.onboarding2.name
            case .third:
                return Asset.onboarding3.name
            }
        }
        
        var text: String {
            switch self {
            case .first:
                return "Готов запустить свой проект? Наше приложение поможет собрать средства и достичь успеха!"
            case .second:
                return "Исследуй мир краудфандинга с нашим приложением. Начни свой путь к прибыли уже сегодня!"
            case .third:
                return "Планируй бюджет для своей идеи. Мы здесь, чтобы помочь осуществить мечту!"
            }
        }
        
        var next: Self {
            switch self {
            case .first:
                return .second
            case .second, .third:
                return .third
            }
        }
    }
}

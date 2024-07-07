//
//  OnboardingView.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 12.06.2024.
//

import SwiftUI

struct OnboardingView: View {
    var item: OnboardingView.OnboardingItem
    @Binding var currentPageIndex: Int
    
    @EnvironmentObject private var rootViewModel: RootContentView.RootContentViewModel
    @StateObject private var viewModel = OnboardingViewModel()
    
    var body: some View {
        ZStack {
            Colors.blackCustom.swiftUIColor
                .ignoresSafeArea()
            
            if item != .third {
                VStack {
                    HStack {
                        Spacer()
                        Button {
                            withAnimation {
                                currentPageIndex = OnboardingView.OnboardingItem.third.rawValue
                            }
                        } label: {
                            Text("Пропустить")
                                .foregroundStyle(.white)
                                .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 14))
                        }
                    }
                    .padding(.horizontal)
                    Spacer()
                }
            }
            
            VStack {
                // Images
                VStack(spacing: 0) {
                    Image(item.imageName)
                        .resizable()
                        .scaledToFit()
                    
                    HStack {
                        Spacer(minLength: 100)
                        Asset.onboardingBlank.swiftUIImage
                            .resizable()
                            .scaledToFit()
                            .padding(.horizontal, 13)
                            .overlay {
                                Text(item.text)
                                    .foregroundStyle(Colors.blackCustom.swiftUIColor)
                                    .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 14))
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 16)
                            }
                    }
                    .offset(y: -40)
                }
                
                Spacer(minLength: 20)
                
                // Buttons
                if item == .third {
                    VStack(spacing: 16) {
                        NextButton(title: "Начать") {
                            rootViewModel.setFlow(.main)
                        }
                        .padding(.horizontal)
                        
                        Button {
                            viewModel.showPrivacyPolicy.toggle()
                        } label: {
                            VStack(spacing: 4) {
                                Text("Выбрав “Начать” Я согласен с")
                                    .foregroundStyle(.white)
                                Text("политикой конфиденциальности")
                                    .foregroundStyle(Colors.firuza.swiftUIColor)
                            }
                            .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 14))
                            .multilineTextAlignment(.center)
                        }
                    }
                } else {
                    Button {
                        withAnimation {
                            currentPageIndex = item.next.rawValue
                        }
                    } label: {
                        HStack(spacing: 8) {
                            Spacer()
                            Text("Далее")
                                .underline()
                                .multilineTextAlignment(.center)
                            Image(systemName: "arrow.right")
                            Spacer()
                        }
                        .foregroundStyle(Colors.firuza.swiftUIColor)
                        .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 16))
                    }
                }
            }
            .padding(.vertical, 100)
        }
        .sheet(isPresented: $viewModel.showPrivacyPolicy) {
            if let url = viewModel.privacyPolicyURL {
                WebView(url: url)
            }
        }
    }
}

#Preview {
    OnboardingView(item: .first, currentPageIndex: .constant(0))
}

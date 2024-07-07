//
//  ProjectsContentView.swift
//  Tradifundint
//
//  Created by Andrii Momot on 07.07.2024.
//

import SwiftUI

struct ProjectsContentView: View {
    @StateObject private var viewModel = ProjectsContentViewModel()
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        ZStack {
            Colors.blueMidnight.swiftUIColor
                .ignoresSafeArea()
            
            VStack {
                Rectangle()
                    .foregroundStyle(Colors.blueMidnight.swiftUIColor)
                    .overlay {
                        VStack {
                            Spacer()
                            
                            HStack(spacing: 10) {
                                Text("Ваши проекты")
                                    .foregroundStyle(.white)
                                    .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 20))
                                
                                Spacer()
                                
                                if viewModel.showSearchButton {
                                    Button {
                                        withAnimation {
                                            viewModel.showSearchButton.toggle()
                                        }
                                    } label: {
                                        Image(systemName: "magnifyingglass")
                                            .renderingMode(.template)
                                            .foregroundStyle(.white)
                                            .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 20))
                                    }
                                }
                            }
                            
                            if !viewModel.showSearchButton {
                                HStack(spacing: 10) {
                                    HStack(spacing: 10) {
                                        Image(systemName: "magnifyingglass")
                                            .renderingMode(.template)
                                            .foregroundStyle(.white)
                                            .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 14))
                                        
                                        TextField(text: $viewModel.searchText) {
                                            Text("Поиск")
                                                .foregroundStyle(Colors.grayLite.swiftUIColor)
                                                .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 10))
                                        }
                                        
                                    }
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 5)
                                    .overlay {
                                        DashedBorder(color: .white)
                                    }
                                    
                                    Button {
                                        withAnimation {
                                            viewModel.showSearchButton.toggle()
                                        }
                                    } label: {
                                        Text("Отменить")
                                            .foregroundStyle(Colors.grayLite.swiftUIColor)
                                            .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 10))
                                    }
                                }
                            }
                            
                            Spacer()
                        }
                        .padding()
                    }
                    .overlay {
                        DashedBorder(cornerRadius: 40)
                    }
                    .frame(width: bounds.width + 3,
                           height: bounds.height * 0.2)
                    .offset(x: 3, y: -3)
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        ForEach(0..<10) { _ in
                            Rectangle()
                                .frame(height: 80)
                        }
                    }
                }
                .overlay {
                    VStack {
                        Spacer()
                        
                        HStack {
                            Spacer()
                            
                            Button {
                               // Pluss action
                            } label: {
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundStyle(Colors.blueMidnight.swiftUIColor)
                                    .frame(width: 50, height: 50)
                                    .overlay {
                                        DashedBorder(color: .white, cornerRadius: 10)
                                    }
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 10)
                                            .foregroundStyle(.white)
                                            .overlay {
                                                Image(systemName: "plus")
                                                    .foregroundStyle(Colors.blackCustom.swiftUIColor)
                                                    .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 20))
                                            }
                                            .offset(x: 8, y: 8)
                                    }
                            }

                            
                            Spacer()
                        }
                        .padding(.bottom, 30)
                    }
                }
            }
            .ignoresSafeArea(edges: .top)
        }
    }
}

#Preview {
    ProjectsContentView()
}

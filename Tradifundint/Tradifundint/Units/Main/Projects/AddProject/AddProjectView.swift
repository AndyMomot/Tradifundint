//
//  AddProjectView.swift
//  Tradifundint
//
//  Created by Andrii Momot on 08.07.2024.
//

import SwiftUI

struct AddProjectView: View {
    @StateObject private var viewModel = AddProjectViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var onAddProject: (() -> Void)?
    
    var body: some View {
        ZStack {
            Colors.blueMidnight.swiftUIColor
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                Spacer(minLength: 30)
        
                VStack(spacing: 22) {
                    HStack {
                        Button {
                            dismiss.callAsFunction()
                        } label: {
                            Image(systemName: "chevron.left")
                                .tint(.white)
                        }
                        Spacer()
                    }
                    .padding()
                    
                    VStack(spacing: 48) {
                        HStack {
                            Spacer()
                            
                            Text("Новый проект")
                                .foregroundStyle(Colors.blackCustom.swiftUIColor)
                                .font(Fonts.SFProDisplay.bold.swiftUIFont(fixedSize: 27))
                                .multilineTextAlignment(.center)
                            
                            Spacer()
                        }
                        
                        VStack(spacing: 15) {
                            InputField(
                                title: "Название проекта",
                                placeholder: "Введите данные...",
                                text: $viewModel.projectName
                            )
                            .onTapGesture {
                                hideKeyboard()
                            }
                            
                            InputField(
                                title: "Необходимые расходы",
                                placeholder: "00",
                                text: $viewModel.necessaryExpenses
                            )
                            .keyboardType(.numberPad)
                            .onTapGesture {
                                hideKeyboard()
                            }
                            
                            InputField(
                                style: .date,
                                title: "Выделенное время до",
                                placeholder: " дд/мм/гг",
                                text: $viewModel.date
                            )
                            .keyboardType(.numberPad)
                            
                            InputField(
                                title: "Прогнозируемый доход",
                                placeholder: "00",
                                text: $viewModel.projectedIncome
                            )
                            .keyboardType(.numberPad)
                            .onTapGesture {
                                hideKeyboard()
                            }
                        }
                        .padding(.bottom)
                    }
                    .padding()
                    .background(Colors.firuza.swiftUIColor)
                    .cornerRadius(20,
                                  corners: [.topLeft,
                                            .bottomLeft,
                                            .bottomRight
                                  ])
                    .padding(.leading)
                    
                    VStack(spacing: 10) {
                        Toggle(isOn: $viewModel.isService) {
                            Text("Сервис")
                                .foregroundStyle(Colors.firuza.swiftUIColor)
                                .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 16))
                        }
                        .tint(Colors.firuza.swiftUIColor)
                        
                        Toggle(isOn: $viewModel.isProduct) {
                            Text("Товар")
                                .foregroundStyle(Colors.firuza.swiftUIColor)
                                .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 16))
                        }
                        .tint(Colors.firuza.swiftUIColor)
                    }
                    .padding(.horizontal)
                    
                    NextButton(title: "Добавить") {
                        viewModel.addProject {
                            dismiss.callAsFunction()
                            onAddProject?()
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                }
            }
            .overlay {
                DashedBorder(cornerRadius: 20)
            }
            .ignoresSafeArea(edges: .top)
            .offset(y: -16)
            
        }
        .navigationBarBackButtonHidden()
        .onChange(of: viewModel.isProduct) { value in
            viewModel.isService = !value
        }
        .onChange(of: viewModel.isService) { value in
            viewModel.isProduct = !value
        }
    }
}

#Preview {
    AddProjectView()
}

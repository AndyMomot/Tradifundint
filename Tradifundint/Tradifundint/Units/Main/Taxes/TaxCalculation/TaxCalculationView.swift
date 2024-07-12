//
//  TaxCalculationView.swift
//  Tradifundint
//
//  Created by Andrii Momot on 12.07.2024.
//

import SwiftUI

struct TaxCalculationView: View {
    @StateObject private var viewModel = TaxCalculationViewModel()
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        NavigationStack {
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
                                    Text("Расчет налогов")
                                        .foregroundStyle(.white)
                                        .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 30))
                                    Spacer()
                                }
                                .padding(.top)
                                .padding(.horizontal)
                            }
                            .offset(x: 3, y: -6)
                        
                        HStack {
                            Spacer()
                            Text("Данные о компании")
                                .foregroundStyle(.white)
                                .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 24))
                                .multilineTextAlignment(.center)
                            Spacer()
                        }
                        
                        VStack(spacing: 20) {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(.clear)
                                .frame(height: 63)
                                .overlay {
                                    DashedBorder()
                                }
                                .overlay {
                                    HStack(spacing: 14) {
                                        Spacer()
                                        Text("ООО")
                                            .foregroundStyle(.white)
                                            .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 20))
                                            .multilineTextAlignment(.center)
                                        
                                        Toggle("", isOn: $viewModel.isLLC)
                                            .tint(Colors.firuza.swiftUIColor)
                                            .labelsHidden()
                                        
                                        //
                                        
                                        Text("ИП")
                                            .foregroundStyle(.white)
                                            .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 20))
                                            .multilineTextAlignment(.center)
                                        
                                        Toggle("", isOn: $viewModel.isIE)
                                            .tint(Colors.firuza.swiftUIColor)
                                            .labelsHidden()
                                        Spacer()
                                    }
                                }
                            
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(.clear)
                                .frame(height: 63)
                                .overlay {
                                    DashedBorder()
                                }
                                .overlay {
                                    HStack(spacing: 14) {
                                        Spacer()
                                        Text("Состоите в реестре МСП?")
                                            .foregroundStyle(.white)
                                            .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 20))
                                            .multilineTextAlignment(.center)
                                        
                                        Toggle("", isOn: $viewModel.isSMERegister)
                                            .tint(Colors.firuza.swiftUIColor)
                                            .labelsHidden()
                                        Spacer()
                                    }
                                }
                            
                            TaxesInputField(title: "Регион",
                                            placeholder: "Начните вводить",
                                            text: $viewModel.region)
                            
                            TaxesInputField(title: "Количество сотрудников",
                                            placeholder: "00",
                                            text: $viewModel.employeesNumber)
                            .keyboardType(.numberPad)
                        }
                        .padding(.horizontal)
                        
                        NextButton(title: "Далее") {
                            viewModel.showPlannedYearIndicatorsView = viewModel.isValidCompanyInfoData
                        }
                        .padding(.horizontal)
                    }
                }
                .ignoresSafeArea(edges: .top)
            }
            .navigationDestination(isPresented: $viewModel.showPlannedYearIndicatorsView) {
                PlannedYearIndicatorsView()
                    .environmentObject(viewModel)
            }
        }
        .onTapGesture {
            hideKeyboard()
        }
        .onChange(of: viewModel.isLLC) { value in
            viewModel.isIE = !value
        }
        
        .onChange(of: viewModel.isIE) { value in
            viewModel.isLLC = !value
        }
    }
}

#Preview {
    TaxCalculationView()
}

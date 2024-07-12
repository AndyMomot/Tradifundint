//
//  PlannedYearIndicatorsView.swift
//  Tradifundint
//
//  Created by Andrii Momot on 12.07.2024.
//

import SwiftUI

struct PlannedYearIndicatorsView: View {
        @EnvironmentObject private var viewModel: TaxCalculationView.TaxCalculationViewModel
    
//    @StateObject private var viewModel = TaxCalculationView.TaxCalculationViewModel()
    @Environment(\.dismiss) private var dismiss
    
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
                            VStack {
                                HStack {
                                    Button {
                                        dismiss.callAsFunction()
                                    } label: {
                                        Image(systemName: "chevron.left")
                                            .tint(.white)
                                    }
                                    Spacer()
                                }
                                .padding(.top, 30)
                                .padding(.horizontal)
                                
                                HStack {
                                    Text("Расчет налогов")
                                        .foregroundStyle(.white)
                                        .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 30))
                                    Spacer()
                                }
                                .padding()
                            }
                        }
                        .offset(x: 3, y: -6)
                    
                    HStack {
                        Spacer()
                        Text("Планируемые показатели за год")
                            .foregroundStyle(.white)
                            .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 24))
                            .multilineTextAlignment(.center)
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    VStack(spacing: 20) {
                        TaxesInputField(title: "Доходы",
                                        placeholder: "00",
                                        text: $viewModel.income)
                        .keyboardType(.numberPad)
                        
                        TaxesInputField(title: "Расходы",
                                        placeholder: "00",
                                        text: $viewModel.cost)
                        .keyboardType(.numberPad)
                        
                        TaxesInputField(title: "В т. ч. на зарплату",
                                        placeholder: "00",
                                        text: $viewModel.includingSalary)
                        .keyboardType(.numberPad)
                    }
                    .padding(.horizontal)
                    
                    VStack(spacing: 25) {
                        
                        HStack {
                            Text("Нестандартная налоговая ставка")
                                .foregroundStyle(.white)
                                .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 20))
                                .multilineTextAlignment(.center)
                            
                            Toggle("", isOn: $viewModel.isNotStandardTaxRate)
                                .tint(Colors.firuza.swiftUIColor)
                                .labelsHidden()
                        }
                        
                        NextButton(title: "Далее") {
                            if viewModel.isValidPlannedYearIndicatorsData {
                                if viewModel.isNotStandardTaxRate {
                                    viewModel.showNotStandardTaxRate.toggle()
                                } else {
                                    viewModel.showCalculatingOne.toggle()
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .ignoresSafeArea(edges: .top)
            .navigationDestination(isPresented: $viewModel.showNotStandardTaxRate) {
                NotStandardTaxRateView()
                    .environmentObject(viewModel)
            }
            .navigationDestination(isPresented: $viewModel.showCalculatingOne) {
                CalculatingView(dismissAfter: 1.5) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                        viewModel.showResultOne.toggle()
                    }
                }

            }
            .navigationDestination(isPresented: $viewModel.showResultOne) {
                TaxesResultView()
                    .environmentObject(viewModel)
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    PlannedYearIndicatorsView()
}

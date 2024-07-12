//
//  NotStandardTaxRateView.swift
//  Tradifundint
//
//  Created by Andrii Momot on 12.07.2024.
//

import SwiftUI

struct NotStandardTaxRateView: View {
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
                        Text("Не стандартная налоговая ставка")
                            .foregroundStyle(.white)
                            .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 24))
                            .multilineTextAlignment(.center)
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    VStack(spacing: 20) {
                        TaxesInputField(title: "Ставка УСН (доходы)",
                                        placeholder: "00 %",
                                        text: $viewModel.rateOfSTSIncome)
                        .keyboardType(.numberPad)
                        
                        TaxesInputField(title: "Ставка УСН (доходы-расходы)",
                                        placeholder: "00 %",
                                        text: $viewModel.rateOfSTSIncomeMinusExpenses)
                        .keyboardType(.numberPad)
                        
                        TaxesInputField(title: "Ставка налога на прибыль",
                                        placeholder: "00 %",
                                        text: $viewModel.IncomeTaxRate)
                        .keyboardType(.numberPad)
                        
                        TaxesInputField(title: "Ставка по патенту",
                                        placeholder: "00 %",
                                        text: $viewModel.patentRate)
                        .keyboardType(.numberPad)
                    }
                    .padding(.horizontal)
                    
                    NextButton(title: "Далее") {
                        if viewModel.isValidNotStandartTaxRateData {
                            viewModel.showCalculatingTwo.toggle()
                            viewModel.calculateNotStandartTaxes()
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .ignoresSafeArea(edges: .top)
            .padding(.bottom)
            
            .navigationDestination(isPresented: $viewModel.showCalculatingTwo) {
                CalculatingView(dismissAfter: 1.5) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                        viewModel.showResultTwo.toggle()
                    }
                }

            }
            .navigationDestination(isPresented: $viewModel.showResultTwo) {
                TaxesResultView()
                    .environmentObject(viewModel)
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    NotStandardTaxRateView()
}

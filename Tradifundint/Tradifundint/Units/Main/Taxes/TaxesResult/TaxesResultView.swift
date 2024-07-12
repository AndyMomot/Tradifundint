//
//  TaxesResultView.swift
//  Tradifundint
//
//  Created by Andrii Momot on 12.07.2024.
//

import SwiftUI

struct TaxesResultView: View {
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
                        Text("Результат:")
                            .foregroundStyle(.white)
                            .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 37))
                            .multilineTextAlignment(.center)
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    VStack(spacing: 30) {
                        HStack {
                            Text("УСН (доходы)")
                                .foregroundStyle(.white)
                                .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 16))
                            Spacer()
                            Text(viewModel.resultIncome.string())
                                .foregroundStyle(Colors.firuza.swiftUIColor)
                                .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 16))
                        }
                        
                        HStack {
                            Text("УСН (доходы-расходы)")
                                .foregroundStyle(.white)
                                .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 16))
                            Spacer()
                            Text(viewModel.resultIncomeMinusCost.string())
                                .foregroundStyle(Colors.firuza.swiftUIColor)
                                .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 16))
                        }
                        
                        HStack {
                            Text("ОСНО")
                                .foregroundStyle(.white)
                                .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 16))
                            Spacer()
                            Text(viewModel.resultGTS.string())
                                .foregroundStyle(Colors.firuza.swiftUIColor)
                                .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 16))
                        }
                    }
                    .padding(.vertical, 60)
                    .padding(.horizontal, 22)
                    .cornerRadius(20, corners: .allCorners)
                    .overlay {
                        DashedBorder(cornerRadius: 20)
                    }
                    
                    Asset.taxes.swiftUIImage
                        .resizable()
                        .scaledToFit()
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    TaxesResultView()
}

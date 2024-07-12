//
//  ROIView.swift
//  Tradifundint
//
//  Created by Andrii Momot on 10.07.2024.
//

import SwiftUI

struct ROIView: View {
    
    @StateObject private var viewModel = ROIViewModel()
    
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
                                    Text("ROI")
                                        .foregroundStyle(.white)
                                        .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 30))
                                    Spacer()
                                }
                                .padding(.top)
                                .padding(.horizontal)
                            }
                            .offset(x: 3, y: -6)
                        
                        VStack(spacing: 15) {
                            ROIDataView(title: "Доход с проекта", value: viewModel.totalIncome.string())
                            ROIDataView(title: "Затраты на проект", value: viewModel.totalCost.string())
                        }
                        .padding(.horizontal)
                        
                        VStack(spacing: 10) {
                            NextButton(title: "Рассчитать") {
                                viewModel.showCalculating.toggle()
                                viewModel.calculateROI()
                            }
                            .padding(.horizontal)
                            
                            Asset.roi.swiftUIImage
                                .resizable()
                                .scaledToFit()
                        }
                    }
                }
                .ignoresSafeArea(edges: .top)
            }
            .navigationDestination(isPresented: $viewModel.showCalculating) {
                CalculatingView(dismissAfter: 1.5) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        viewModel.showROIResult.toggle()
                    }
                }
            }
            .navigationDestination(isPresented: $viewModel.showROIResult) {
                ROIResultView()
                    .environmentObject(viewModel)
            }
        }
        .onAppear {
            withAnimation {
                viewModel.getData()
            }
        }
    }
}

#Preview {
    ROIView()
}

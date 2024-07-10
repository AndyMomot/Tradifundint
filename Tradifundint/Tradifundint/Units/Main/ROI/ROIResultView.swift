//
//  ROIResultView.swift
//  Tradifundint
//
//  Created by Andrii Momot on 10.07.2024.
//

import SwiftUI

struct ROIResultView: View {
    @EnvironmentObject private var rootViewModel: ROIView.ROIViewModel
    @Environment(\.dismiss) private var dismiss
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        ZStack {
            Colors.blueMidnight.swiftUIColor
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack {
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
                                    Text("ROI")
                                        .foregroundStyle(.white)
                                        .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 30))
                                    Spacer()
                                }
                                .padding()
                            }
                        }
                        .offset(x: 3, y: -6)
                    
                    VStack(spacing: 25) {
                        
                        HStack {
                            Spacer()
                            Text("Результат ROI:")
                                .foregroundStyle(.white)
                                .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 37))
                            Spacer()
                        }
                        .padding()
                        
                        Circle()
                            .foregroundStyle(.clear)
                            .frame(width: bounds.width * 0.58)
                            .overlay {
                                DashedBorder(cornerRadius: (bounds.width * 0.58) / 2)
                            }
                            .overlay {
                                Text(rootViewModel.roiValue.string() + "%")
                                    .foregroundStyle(Colors.firuza.swiftUIColor)
                                    .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 64))
                            }
                        
                        Asset.roi.swiftUIImage
                            .resizable()
                            .scaledToFit()
                        
                    }
                    .cornerRadius(20, corners: .allCorners)
                    .overlay {
                        DashedBorder(cornerRadius: 20)
                    }
                        
                }
            }
            .ignoresSafeArea(edges: .top)
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    ROIResultView()
}

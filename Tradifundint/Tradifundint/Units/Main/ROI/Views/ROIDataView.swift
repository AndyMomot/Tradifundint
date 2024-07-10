//
//  ROIDataView.swift
//  Tradifundint
//
//  Created by Andrii Momot on 10.07.2024.
//

import SwiftUI

struct ROIDataView: View {
    var title: String
    var value: String
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.clear)
                .overlay {
                    DashedBorder(cornerRadius: 10)
                }
            
            HStack {
                Text(title)
                    .foregroundStyle(Colors.blackCustom.swiftUIColor)
                    .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 17))
                    .padding()
                
                Spacer()
                
                VStack {
                    Spacer()
                    
                    HStack {
                        Image(systemName: "arrow.right")
                            .foregroundStyle(.white)
                            .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 28))
                            .offset(x: -4)
                        
                        Spacer()
                        
                        Text(value)
                            .foregroundStyle(Colors.blackCustom.swiftUIColor)
                            .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 17))
                            .padding()
                        
                        Spacer()
                    }
                    .frame(width: bounds.width * 0.4)
                    
                    Spacer()
                }
                .background(Colors.firuza.swiftUIColor)
                .cornerRadius(10, corners: .allCorners)
            }
            .background(.white)
            .cornerRadius(10, corners: .allCorners)
            .padding(.vertical, 13)
            .padding(.horizontal, 15)
        }
    }
}

#Preview {
    ZStack {
        Colors.blueMidnight.swiftUIColor
        
        ROIDataView(title: "Доход с проекта",
                    value: "10000")
        .frame(height: 93)
    }
}

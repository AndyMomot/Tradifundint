//
//  TaxesInputField.swift
//  Tradifundint
//
//  Created by Andrii Momot on 12.07.2024.
//

import SwiftUI

struct TaxesInputField: View {
    var title: String
    var placeholder: String
    @Binding var text: String
    
    var body: some View {
        HStack {
            Spacer()
            VStack(spacing: 14) {
                Text(title)
                    .foregroundStyle(.white)
                    .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 14))
                    .multilineTextAlignment(.center)
                
                HStack {
                    Spacer(minLength: 40)
                    
                    TextField(text: $text) {
                        Text(placeholder)
                            .foregroundStyle(Colors.grayLite.swiftUIColor)
                            .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 14))
                            .multilineTextAlignment(.center)
                    }
                    .foregroundStyle(.white)
                    .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 14))
                    .multilineTextAlignment(.center)
                    
                    Spacer(minLength: 40)
                }
            }
            .padding(.vertical)
            Spacer()
        }
        .cornerRadius(10, corners: .allCorners)
        .overlay {
            DashedBorder()
        }
    }
}

#Preview {
    ZStack {
        Colors.blueMidnight.swiftUIColor
        TaxesInputField(title: "Регион",
                        placeholder: "Начните вводить",
                        text: .constant(""))
        .padding(.horizontal)
    }
}

//
//  NextButton.swift
//  Goobeltoin

import SwiftUI

struct NextButton: View {
    var title: String
    var onPress: () -> Void
    
    var body: some View {
        Button {
            onPress()
        } label: {
            HStack {
                Spacer()
                Text(title)
                    .foregroundStyle(.white)
                    .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 20))
                Spacer()
            }
            .padding(.vertical)
            .background(Colors.firuza.swiftUIColor)
            .cornerRadius(8, corners: .allCorners)
        }

    }
}

#Preview {
    NextButton(title: "Press me") {}
}

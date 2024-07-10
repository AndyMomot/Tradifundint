//
//  CalculatingView.swift
//  Tradifundint
//
//  Created by Andrii Momot on 10.07.2024.
//

import SwiftUI

struct CalculatingView: View {
    @Environment(\.dismiss) private var dismiss
    var dismissAfter: Double?
    var onDismiss: (() -> Void)?
    
    var body: some View {
        ZStack {
            Colors.blueMidnight.swiftUIColor
                .ignoresSafeArea()
            
            VStack(spacing: 17) {
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
                
                Spacer()
                
                Asset.progress.swiftUIImage
                    .resizable()
                    .scaledToFit()
                    .overlay {
                        Text("Подождите, пожалуйста, мы проводим подсчет.")
                            .foregroundStyle(Colors.firuza.swiftUIColor)
                            .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 25))
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                
                Asset.waiting.swiftUIImage
                    .resizable()
                    .scaledToFit()
                
                Spacer()
            }
        }
        .onAppear {
            if let timeout = dismissAfter {
                DispatchQueue.main.asyncAfter(deadline: .now() + timeout) {
                    dismiss.callAsFunction()
                    onDismiss?()
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    CalculatingView()
}

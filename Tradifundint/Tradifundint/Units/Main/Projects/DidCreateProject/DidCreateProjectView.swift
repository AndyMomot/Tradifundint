//
//  DidCreateProjectView.swift
//  Tradifundint
//
//  Created by Andrii Momot on 09.07.2024.
//

import SwiftUI

struct DidCreateProjectView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Colors.blueMidnight.swiftUIColor
                .ignoresSafeArea()
            
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
                .padding()
                
                Spacer()
                
                Text("Новый проект был успешно добавлен!")
                    .foregroundStyle(Colors.firuza.swiftUIColor)
                    .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 37))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Spacer()
                
                Asset.success.swiftUIImage
                    .resizable()
                    .scaledToFit()
                
                Spacer()
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    DidCreateProjectView()
}

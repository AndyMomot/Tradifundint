//
//  PreloaderView.swift
//  Tradifundint
//
//  Created by Andrii Momot on 07.07.2024.
//

import SwiftUI

struct PreloaderView: View {
    @StateObject private var viewModel = PreloaderViewModel()
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        ZStack {
            Asset.launch.swiftUIImage
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Asset.logo.swiftUIImage
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal, 50)
                
                Spacer()
            }
            
            VStack {
                Spacer()
                
                ProgressView(value: viewModel.progress)
                    .tint(Colors.firuza.swiftUIColor)
                    .background(.white)
                    .cornerRadius(3, corners: .allCorners)
                    .frame(height: 8)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 44)
            }
        }
        .onReceive(viewModel.timer) { input in
            DispatchQueue.main.async {
                withAnimation {
                    viewModel.updateProgress()
                }
            }
        }
    }
}

#Preview {
    PreloaderView()
}

//
//  TabBar.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 13.06.2024.
//

import SwiftUI

struct TabBar: View {
    @StateObject private var viewModel = TabBarViewModel()
    
    var body: some View {
        TabView(selection: $viewModel.selection) {
            ROIView()
                .tag(TabBarSelectionView.roi.rawValue)
            
            ProjectsContentView()
                .tag(TabBarSelectionView.projects.rawValue)
            
            Text("Taxes")
                .tag(TabBarSelectionView.taxes.rawValue)
            
            Text("Settings")
                .tag(TabBarSelectionView.settings.rawValue)
        }
        .edgesIgnoringSafeArea(.bottom)
        .overlay {
            VStack {
                Spacer()
                TabBarCustomView(selectedItem: $viewModel.selection)
                    .frame(height: UIScreen.main.bounds.height * 0.12)
                    .offset(y: 9)
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

#Preview {
    TabBar()
}

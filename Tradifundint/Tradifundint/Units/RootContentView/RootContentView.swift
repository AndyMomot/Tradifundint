//
//  RootContentView.swift
//  Tradifundint
//
//  Created by Andrii Momot on 07.07.2024.
//

import SwiftUI

struct RootContentView: View {
    @StateObject private var viewModel = RootContentViewModel()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    RootContentView()
}

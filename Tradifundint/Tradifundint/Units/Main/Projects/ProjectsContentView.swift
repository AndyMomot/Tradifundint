//
//  ProjectsContentView.swift
//  Tradifundint
//
//  Created by Andrii Momot on 07.07.2024.
//

import SwiftUI

struct ProjectsContentView: View {
    @StateObject private var viewModel = ProjectsContentViewModel()
    
    var body: some View {
        ZStack {
            Colors.blueMidnight.swiftUIColor
                .ignoresSafeArea()
        }
    }
}

#Preview {
    ProjectsContentView()
}

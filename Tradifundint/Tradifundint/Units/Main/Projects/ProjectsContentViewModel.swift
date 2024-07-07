//
//  ProjectsContentViewModel.swift
//  Tradifundint
//
//  Created by Andrii Momot on 07.07.2024.
//

import Foundation

extension ProjectsContentView {
    final class ProjectsContentViewModel: ObservableObject {
        @Published var showSearchButton = true
        @Published var searchText = ""
    }
}

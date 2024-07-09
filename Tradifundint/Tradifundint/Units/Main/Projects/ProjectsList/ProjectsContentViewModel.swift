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
        @Published var showAddProject = false
        @Published var projects: [AddProjectView.ProjectModel] = []
        @Published var showSuccess = false
        
        func getProjects() {
            DispatchQueue.main.async { [weak self] in
                self?.projects = DefaultsService.projects
            }
        }
        
        func delete(product: AddProjectView.ProjectModel) {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                var projects = DefaultsService.projects
                if let index = projects.firstIndex(where: {
                    $0.id == product.id
                }) {
                    projects.remove(at: index)
                    DefaultsService.projects = projects
                    self.getProjects()
                }
            }
        }
        
        func search(containing character: String)  {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                let projectItems = DefaultsService.projects
                
                if character.isEmpty {
                    self.projects = projectItems
                } else {
                    self.projects = projectItems.filter {
                        $0.name.localizedCaseInsensitiveContains(character)
                    }
                }
            }
        }
    }
}

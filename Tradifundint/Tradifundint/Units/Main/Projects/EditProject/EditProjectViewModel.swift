//
//  EditProjectViewModel.swift
//  Tradifundint
//
//  Created by Andrii Momot on 09.07.2024.
//

import Foundation

extension EditProjectView {
    final class EditProjectViewModel: ObservableObject {
        @Published var isEditing = false
        @Published var necessaryExpenses = ""
        @Published var timeDifference = ""
        @Published var date = ""
        @Published var projectedIncome = ""
        @Published var selectedDate = Date()
        
        func updateProject(model: AddProjectView.ProjectModel,
                           completion: @escaping (AddProjectView.ProjectModel) -> Void) {
            guard validateFields() else { return }
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                var projects = DefaultsService.projects
                if let index = projects.firstIndex(where: {
                    $0.id == model.id
                }) {
                    var project = projects[index]
                    project.necessaryExpenses = Double(self.necessaryExpenses) ?? .zero
                    project.date = self.selectedDate
                    project.projectedIncome = Double(self.projectedIncome) ?? .zero
                    
                    projects[index] = project
                    DefaultsService.projects = projects
                    completion(project)
                }
            }
        }
        
        func updateUI(with model: AddProjectView.ProjectModel) {
            necessaryExpenses = model.necessaryExpenses.string()
            timeDifference = model.timeDifference
            selectedDate = model.date
            projectedIncome = model.projectedIncome.string()
        }
        
        private func validateFields() -> Bool {
            guard let necessaryExpenses = Double(self.necessaryExpenses),
                  necessaryExpenses > .zero,
                  let projectedIncome = Double(self.projectedIncome),
                  projectedIncome > .zero
            else {
                return false
            }
            
            return true
        }
    }
}

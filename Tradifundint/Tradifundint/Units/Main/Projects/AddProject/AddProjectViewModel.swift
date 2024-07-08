//
//  AddProjectViewModel.swift
//  Tradifundint
//
//  Created by Andrii Momot on 08.07.2024.
//

import Foundation

extension AddProjectView {
    final class AddProjectViewModel: ObservableObject {
        @Published var projectName = ""
        @Published var necessaryExpenses = ""
        @Published var date = ""
        @Published var projectedIncome = ""
        
        func addProject(completion: @escaping () -> Void) {
            guard validateFields() else { return }
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                let project = ProjectModel(
                    name: self.projectName,
                    necessaryExpenses: Double(necessaryExpenses) ?? .zero,
                    date:  date.toDate(format: .ddMMyy) ?? .init(),
                    projectedIncome: Double(projectedIncome) ?? .zero)
                
                DefaultsService.addProject(item: project)
                completion()
            }
            
        }
        
        private func validateFields() -> Bool {
            guard !projectName.isEmpty,
                  let necessaryExpenses = Double(self.necessaryExpenses),
                  necessaryExpenses > .zero,
                  date.toDate(format: .ddMMyy) != nil,
                  let projectedIncome = Double(self.projectedIncome),
                  projectedIncome > .zero
            else {
                return false
            }
            
            return true
        }
    }
}

extension AddProjectView {
    struct ProjectModel: Identifiable, Codable {
        private(set) var id = UUID().uuidString
        private(set) var dateCreated = Date()
        var name: String
        var necessaryExpenses: Double
        var date: Date
        var projectedIncome: Double
    }
}

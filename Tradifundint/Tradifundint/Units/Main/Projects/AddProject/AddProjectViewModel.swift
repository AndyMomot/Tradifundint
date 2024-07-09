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
        @Published var isService = false
        @Published var isProduct = false
        
        private var projectType: AddProjectView.ProjectModel.ProjectType? {
            if isService {
                return .service
            } else if isProduct {
                return .product
            } else {
                return nil
            }
        }
        
        func addProject(completion: @escaping () -> Void) {
            guard validateFields() else { return }
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                let project = ProjectModel(
                    name: self.projectName,
                    necessaryExpenses: Double(self.necessaryExpenses) ?? .zero,
                    date:  self.date.toDate(format: .ddMMyy) ?? .init(),
                    projectedIncome: Double(self.projectedIncome) ?? .zero,
                    projectType: self.projectType ?? .product)
                
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
                  projectedIncome > .zero,
                  projectType != nil
            else {
                return false
            }
            
            return true
        }
    }
}

extension AddProjectView {
    struct ProjectModel: Identifiable, Codable, Hashable {
        private(set) var id = UUID().uuidString
        private(set) var dateCreated = Date()
        var name: String
        var necessaryExpenses: Double
        var date: Date
        var projectedIncome: Double
        var projectType: ProjectType
        
        var timeDifference: String {
            let calendar = Calendar.current
            
            let components = calendar.dateComponents([.year, .month, .day],
                                                     from: .init(),
                                                     to: date)
            
            let years = components.year ?? 0
            let months = components.month ?? 0
            let days = components.day ?? 0
            
            var result = ""
            
            if years > 0 {
                result += "\(years) \(years == 1 ? "год" : "лет") "
            }
            
            if months > 0 {
                result += "\(months) \(months == 1 ? "месяц" : "месяцов") "
            }
            
            if days > 0 || result.isEmpty {
                result += "\(days) \(days == 1 ? "день" : "дней")"
            }
            
            return result.trimmingCharacters(in: .whitespaces)
        }
    }
}

extension AddProjectView.ProjectModel {
    enum ProjectType: Codable {
        case service
        case product
        
        var imageName: String {
            switch self {
            case .service:
                return Asset.service.name
            case .product:
                return Asset.product.name
            }
        }
    }
}

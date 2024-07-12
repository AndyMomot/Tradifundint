//
//  ROIViewModel.swift
//  Tradifundint
//
//  Created by Andrii Momot on 10.07.2024.
//

import Foundation

extension ROIView {
    final class ROIViewModel: ObservableObject {
        @Published var totalIncome: Double = .zero
        @Published var totalCost: Double = .zero
        @Published var roiValue: Double = .zero
        @Published var showCalculating = false
        @Published var showROIResult = false
        
        func getData() {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                let projects = DefaultsService.projects
                self.totalIncome = projects.map { $0.projectedIncome }.reduce(0) { $0 + $1 }
                self.totalCost = projects.map { $0.necessaryExpenses }.reduce(0) { $0 + $1 }
            }
        }
        
        func calculateROI() {
            // Формула ROI:
            // (Доход с проекта — Затраты на проект) ÷ Затраты на проект × 100%
            guard totalIncome > .zero && totalCost > .zero else {
                roiValue = .zero
                return
            }
            roiValue = (totalIncome - totalCost) / totalCost * 100
        }
    }
}

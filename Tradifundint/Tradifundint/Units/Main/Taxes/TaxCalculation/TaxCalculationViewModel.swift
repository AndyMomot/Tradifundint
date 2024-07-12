//
//  TaxCalculationViewModel.swift
//  Tradifundint
//
//  Created by Andrii Momot on 12.07.2024.
//

import Foundation

extension TaxCalculationView {
    final class TaxCalculationViewModel: ObservableObject {
        
        // MARK: - Company information
        @Published var isLLC = false // OOO
        @Published var isIE = false // ИП
        @Published var isSMERegister = false // МСП
        @Published var region = ""
        @Published var employeesNumber = ""
        
        @Published var showPlannedYearIndicatorsView = false
        
        var isValidCompanyInfoData: Bool {
            guard isLLC || isIE,
                  !region.isEmpty,
                  Int(employeesNumber) != nil
            else {
                return false
            }
            
            return true
        }
        
        // MARK: - Planned indicators for the year
        @Published var income = ""
        @Published var cost = ""
        @Published var includingSalary = ""
        @Published var isNotStandardTaxRate = false
        
        @Published var showNotStandardTaxRate = false
        @Published var showCalculatingOne = false
        @Published var showResultOne = false
        
        @Published var showCalculatingTwo = false
        @Published var showResultTwo = false
        
        var isValidPlannedYearIndicatorsData: Bool {
            guard Double(income) != nil,
                  Double(cost) != nil,
                  Double(includingSalary) != nil
            else {
                return false
            }
            
            return true
        }
         
        // MARK: - Not standard tax rate
        @Published var rateOfSTSIncome = "" // Ставка УСН (доходы)
        @Published var rateOfSTSIncomeMinusExpenses = "" // Ставка УСН (доходы-расходы)
        @Published var IncomeTaxRate = "" // Ставка налога на прибыль
        @Published var patentRate = "" // Ставка по патенту
        
        var isValidNotStandartTaxRateData: Bool {
            guard Double(rateOfSTSIncome) != nil,
                  Double(rateOfSTSIncomeMinusExpenses) != nil,
                  Double(IncomeTaxRate) != nil,
                  Double(patentRate) != nil
            else {
                return false
            }
            
            return true
        }
        
        // MARK: - Result
        @Published var resultIncome = 0.0
        @Published var resultIncomeMinusCost = 0.0
        @Published var resultGTS = 0.0 // ОСНО
        
        func calculateResult() {
            
        }
    }
}

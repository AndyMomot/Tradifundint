//
//  ProjectCell.swift
//  Tradifundint
//
//  Created by Andrii Momot on 09.07.2024.
//

import SwiftUI

struct ProjectCell: View {
    var model: AddProjectView.ProjectModel
    var onDelete: () -> Void
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(.clear)
                .overlay {
                    DashedBorder(cornerRadius: 20)
                }
                .offset(x: -5, y: -5)
            
            HStack(spacing: 10) {
                VStack(alignment: .leading) {
                    Text(model.name)
                        .foregroundStyle(Colors.blackCustom.swiftUIColor)
                        .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 16))
                        .padding()
                    
                    Spacer()
                    
                    Image(model.projectType.imageName)
                        .resizable()
                        .scaledToFit()
                }
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 28) {
                    InfoRow(imageName: Asset.cost.name,
                            value: "- " + model.necessaryExpenses.string())
                    InfoRow(imageName: Asset.time.name,
                            value: model.timeDifference)
                    
                    InfoRow(imageName: Asset.income.name,
                            value: "+ " + model.projectedIncome.string())
                    
                    Spacer()
                    
                    Button {
                        onDelete()
                    } label: {
                        HStack(spacing: 20) {
                            Image(systemName: "trash")
                                .resizable()
                                .scaledToFit()
                                .tint(Colors.redCustom.swiftUIColor)
                                .frame(width: 20, height: 20)
                            
                            Text("Удалить")
                                .foregroundStyle(Colors.redCustom.swiftUIColor)
                                .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 12))
                        }
                    }

                }
                .padding()
            }
            .background(Colors.firuza.swiftUIColor)
            .cornerRadius(20, corners: .allCorners)
            .offset(x: 5, y: 5)
        }
    }
}

#Preview {
    ProjectCell(model: .init(
        name: "Новая услуга 1",
        necessaryExpenses: 1000,
        date: .init().addOrSubtract(component: .month,
                                    value: 1),
        projectedIncome: 1100,
        projectType: .service)
    ) {}
    .frame(width: 361, height: 228)
}

fileprivate struct InfoRow: View {
    var imageName: String
    var value: String
    
    var body: some View {
        HStack(spacing: 20) {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
            
            Text(value)
                .foregroundStyle(Colors.blackCustom.swiftUIColor)
                .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 12))
        }
    }
}

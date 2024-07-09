//
//  EditProjectView.swift
//  Tradifundint
//
//  Created by Andrii Momot on 09.07.2024.
//

import SwiftUI

struct EditProjectView: View {
    @StateObject private var viewModel = EditProjectViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var model: AddProjectView.ProjectModel
    var onDismiss: () -> Void
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        ZStack {
            Colors.blueMidnight.swiftUIColor
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 14) {
                    // Title
                    Rectangle()
                        .foregroundStyle(.clear)
                        .frame(height: bounds.height * 0.2)
                        .overlay {
                            DashedBorder(cornerRadius: 50)
                        }
                        .offset(y: -6)
                        .overlay {
                            RoundedRectangle(cornerRadius: 50)
                                .foregroundStyle(Colors.firuza.swiftUIColor)
                                .offset(x: 10, y: -20)
                                .overlay {
                                    HStack(spacing: 20) {
                                        Button {
                                            onDismiss()
                                            dismiss.callAsFunction()
                                        } label: {
                                            Image(systemName: "chevron.left")
                                                .tint(Colors.blackCustom.swiftUIColor)
                                        }
                                        
                                        Text(model.name)
                                            .foregroundStyle(Colors.blackCustom.swiftUIColor)
                                        Spacer()
                                    }
                                    .font(Fonts.SFProDisplay.medium.swiftUIFont(fixedSize: 30))
                                    .padding(.horizontal, 24)
                                }
                        }
                    
                    // Body
                    
                    VStack(spacing: 37) {
                        HStack {
                            Spacer()
                            
                            Button {
                                withAnimation {
                                    viewModel.isEditing.toggle()
                                }
                            } label: {
                                var imageName: String {
                                    if viewModel.isEditing {
                                        return Asset.disk.name
                                    } else {
                                        return Asset.pancil.name
                                    }
                                }
                                
                                Image(imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 14, height: 14)
                            }
                            
                        }
                        .padding()
                        
                        EditItem(imageName: Asset.cost.name,
                                 title: "Необходимые расходы",
                                 canEdit: viewModel.isEditing,
                                 text: $viewModel.necessaryExpenses)
                        .keyboardType(.numberPad)
                        .onTapGesture {
                            hideKeyboard()
                        }
                        
                        EditDateItem(imageName: Asset.time.name,
                                     title: "Выделенное время",
                                     canEdit: viewModel.isEditing,
                                     text: viewModel.timeDifference,
                                     date: $viewModel.selectedDate)
                        
                        EditItem(imageName: Asset.income.name,
                                 title: "Прогнозированный доход",
                                 canEdit: viewModel.isEditing,
                                 text: $viewModel.projectedIncome)
                        .keyboardType(.numberPad)
                        .onTapGesture {
                            hideKeyboard()
                        }
                        
                        Image(model.projectType.imageName)
                            .resizable()
                            .scaledToFit()
                            .onTapGesture {
                                hideKeyboard()
                            }
                    }
                    .padding(.horizontal)
                    .cornerRadius(20, corners: .allCorners)
                    .overlay {
                        DashedBorder(cornerRadius: 20)
                    }
                }
            }
            .ignoresSafeArea(edges: .top)
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            viewModel.updateUI(with: self.model)
        }
        .onChange(of: viewModel.isEditing) { isEditing in
            if !isEditing {
                viewModel.updateProject(model: model) { newModel in
                    viewModel.updateUI(with: newModel)
                }
            }
        }
    }
}

#Preview {
    EditProjectView(model: .init(
        name: "Новая услуга 1",
        necessaryExpenses: 1000,
        date: .init()
            .addOrSubtract(component: .month,
                                    value: 1)
            .addOrSubtract(component: .day,
                                    value: 2),
        projectedIncome: 1100,
        projectType: .service)) {}
}

fileprivate struct EditItem: View {
    var imageName: String
    var title: String
    var canEdit: Bool
    @Binding var text: String
    
    var body: some View {
        VStack(spacing: 8) {
            Image(imageName)
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .foregroundStyle(.white)
                .frame(width: 20, height: 20)
            
            Text(title)
                .foregroundStyle(.white)
                .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 12))
            
            Divider()
                .overlay {
                    DashedBorder(color: Colors.grayLite.swiftUIColor,
                                 dash: [8, 10])
                }
                .padding(.horizontal)
            
            if canEdit {
                TextField(text: $text) {
                    Text("Ведите данные")
                        .foregroundStyle(Colors.grayLite.swiftUIColor)
                        .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 16))
                }
                .foregroundStyle(.white)
                .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 16))
            } else {
                Text(text)
                    .foregroundStyle(.white)
                    .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 16))
            }
        }
    }
}

fileprivate struct EditDateItem: View {
    var imageName: String
    var title: String
    var canEdit: Bool
    var text: String
    @Binding var date: Date
    
    var body: some View {
        VStack(spacing: 8) {
            Image(imageName)
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .foregroundStyle(.white)
                .frame(width: 20, height: 20)
            
            Text(title)
                .foregroundStyle(.white)
                .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 12))
            
            Divider()
                .overlay {
                    DashedBorder(color: Colors.grayLite.swiftUIColor,
                                 dash: [8, 10])
                }
                .padding(.horizontal)
            
            if canEdit {
                DatePicker("",
                           selection: $date,
                           in: Date()...,
                           displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .labelsHidden()
                    .background(Colors.firuza.swiftUIColor)
                    .cornerRadius(20, corners: .allCorners)
            } else {
                Text(text)
                    .foregroundStyle(.white)
                    .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 16))
            }
        }
    }
}

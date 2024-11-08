//
//  ProjectsContentView.swift
//  Tradifundint
//
//  Created by Andrii Momot on 07.07.2024.
//

import SwiftUI

struct ProjectsContentView: View {
    @StateObject private var viewModel = ProjectsContentViewModel()
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Colors.blueMidnight.swiftUIColor
                    .ignoresSafeArea()
                
                VStack {
                    Rectangle()
                        .foregroundStyle(Colors.blueMidnight.swiftUIColor)
                        .overlay {
                            VStack {
                                Spacer()
                                
                                HStack(spacing: 10) {
                                    Text("Ваши проекты")
                                        .foregroundStyle(.white)
                                        .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 20))
                                    
                                    Spacer()
                                    
                                    if viewModel.showSearchButton {
                                        Button {
                                            withAnimation {
                                                viewModel.showSearchButton.toggle()
                                            }
                                        } label: {
                                            Image(systemName: "magnifyingglass")
                                                .renderingMode(.template)
                                                .foregroundStyle(.white)
                                                .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 20))
                                        }
                                    }
                                }
                                
                                if !viewModel.showSearchButton {
                                    HStack(spacing: 10) {
                                        HStack(spacing: 10) {
                                            Image(systemName: "magnifyingglass")
                                                .renderingMode(.template)
                                                .foregroundStyle(.white)
                                                .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 14))
                                            
                                            TextField(text: $viewModel.searchText) {
                                                Text("Поиск")
                                                    .foregroundStyle(Colors.grayLite.swiftUIColor)
                                                    .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 10))
                                            }
                                            .foregroundStyle(.white)
                                            .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 10))
                                        }
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 5)
                                        .overlay {
                                            DashedBorder(color: .white)
                                        }
                                        
                                        Button {
                                            withAnimation {
                                                viewModel.searchText = ""
                                                viewModel.showSearchButton.toggle()
                                            }
                                        } label: {
                                            Text("Отменить")
                                                .foregroundStyle(Colors.grayLite.swiftUIColor)
                                                .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 10))
                                        }
                                    }
                                }
                                
                                Spacer()
                            }
                            .padding()
                        }
                        .overlay {
                            DashedBorder(cornerRadius: 40)
                        }
                        .frame(width: bounds.width + 3,
                               height: bounds.height * 0.2)
                        .offset(x: 3, y: -3)
                    
                    // Projects
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 30) {
                            ForEach(viewModel.projects) { product in
                                NavigationLink(value: product) {
                                    ProjectCell(model: product) { // on delete
                                        withAnimation {
                                            viewModel.delete(product: product)
                                        }
                                    }
                                }
                            }
                        }
                        .padding()
                    }
                    .overlay {
                        VStack {
                            Spacer()
                            
                            HStack {
                                Spacer()
                                
                                Button {
                                    withAnimation {
                                        viewModel.showAddProject.toggle()
                                    }
                                } label: {
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundStyle(.clear)
                                        .frame(width: 50, height: 50)
                                        .overlay {
                                            DashedBorder(color: .white, cornerRadius: 10)
                                        }
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 10)
                                                .foregroundStyle(.white)
                                                .overlay {
                                                    Image(systemName: "plus")
                                                        .foregroundStyle(Colors.blackCustom.swiftUIColor)
                                                        .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 20))
                                                }
                                                .offset(x: 8, y: 8)
                                        }
                                }
                                
                                
                                Spacer()
                            }
                            .padding(.bottom, 30)
                        }
                    }
                }
                .ignoresSafeArea(edges: .top)
            }
            .navigationDestination(isPresented: $viewModel.showAddProject) {
                AddProjectView() { // on Add
                    viewModel.getProjects()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        viewModel.showSuccess.toggle()
                    }
                }
            }
            .navigationDestination(isPresented: $viewModel.showSuccess) {
                DidCreateProjectView()
            }
            .navigationDestination(for: AddProjectView.ProjectModel.self) { model in
                EditProjectView(model: model) {
                    viewModel.getProjects()
                }
            }
        }
        .onAppear {
            viewModel.getProjects()
        }
        .onChange(of: viewModel.searchText) { value in
            viewModel.search(containing: value)
        }
    }
}

#Preview {
    ProjectsContentView()
}

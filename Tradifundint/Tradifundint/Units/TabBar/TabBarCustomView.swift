//
//  TabBarCustomView.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 13.06.2024.
//

import SwiftUI

struct TabBarCustomView: View {
    @Binding var selectedItem: Int
    
    @State private var items: [TabBar.Item] = [
        .init(imageName: Asset.roiTab.name),
        .init(imageName: Asset.projectsTab.name),
        .init(imageName: Asset.taxesTab.name),
        .init(imageName: Asset.settingsTab.name)
    ]
    
    private var arrange: [Int] {
        Array(0..<items.count)
    }
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        ZStack {
            Colors.blueMidnight.swiftUIColor
            
            RoundedRectangle(cornerRadius: 30)
                .foregroundStyle(Colors.blueMidnight.swiftUIColor)
                .overlay {
                    HStack {
                        ForEach(arrange, id: \.self) { index in
                            let item = items[index]
                            let isSelectedItem = index == selectedItem
                            let imageSize = bounds.width * 0.086
                            
                            Button {
                                selectedItem = index
                            } label: {
                                Image(item.imageName)
                                    .renderingMode(.template)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: imageSize, height: imageSize)
                                    .padding()
                                    .tint(isSelectedItem ? Colors.firuza.swiftUIColor : .white)
                            }
                            
                            if index < arrange.count - 1 {
                                Spacer()
                                Divider()
                                    .overlay {
                                        DashedBorder(
                                            color: Colors.firuza.swiftUIColor.opacity(0.3),
                                            lineWidth: 3,
                                            dash: [8, 10],
                                            cornerRadius: 0
                                        )
                                    }
                                Spacer()
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .overlay {
                    DashedBorder()
                }
                .padding(6)
        }
    }
}

#Preview {
    TabBarCustomView(selectedItem: .constant(0))
        .previewLayout(.fixed(width: 393, height: 48))
}

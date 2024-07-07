//
//  DashedBorder.swift
//  Tradifundint
//
//  Created by Andrii Momot on 07.07.2024.
//

import SwiftUI

struct DashedBorder: View {
    var color: Color
    var lineWidth: CGFloat
    var dash: [CGFloat]
    var cornerRadius: CGFloat
    
    init(color: Color = Colors.firuza.swiftUIColor,
         lineWidth: CGFloat = 4, 
         dash: [CGFloat] = [10, 10],
         cornerRadius: CGFloat = 10) {
        self.color = color
        self.lineWidth = lineWidth
        self.dash = dash
        self.cornerRadius = cornerRadius
    }

    var body: some View {
        GeometryReader { geometry in
            RoundedRectangle(cornerRadius: cornerRadius)
                           .stroke(style: StrokeStyle(lineWidth: lineWidth, dash: dash))
                           .foregroundColor(color)
                           .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}

#Preview {
    DashedBorder()
        .frame(width: 200, height: 50)
}

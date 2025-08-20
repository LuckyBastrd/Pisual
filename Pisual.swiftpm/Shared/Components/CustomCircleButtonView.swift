//
//  CustomCircleButtonView.swift
//  Pisual
//
//  Created by Lucky on 17/02/25.
//

import SwiftUI

struct CustomCircleButtonView: View {
    
    var buttonWidth: CGFloat = 70
    var buttonHeight: CGFloat = 70
    var buttonStroke: CGFloat = 5
    
    var iconName: String
    var iconFont: Font = .title
    var iconFontWeight: Font.Weight = .regular
    
    var action: () -> Void
    
    var body: some View {
        Button(action: action, label: {
            ZStack {
                Circle()
                    .frame(width: buttonWidth, height: buttonHeight)
                    .foregroundStyle(AppColors.primary)
                    .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                    .overlay(
                        RoundedRectangle(cornerRadius: 50)
                            .inset(by: 2.5)
                            .stroke(AppColors.secondary, lineWidth: buttonStroke)
                    )
                
                Image(systemName: iconName)
                    .font(iconFont)
                    .fontWeight(iconFontWeight)
                    .foregroundStyle(AppColors.textContrast)
                    .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
            }
        })
        .buttonStyle(PlainButtonStyle())
    }
}

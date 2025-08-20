//
//  CustomRoundedRectangleButtonView.swift
//  Pisual
//
//  Created by Lucky on 17/02/25.
//

import SwiftUI

struct CustomRoundedRectangleButtonView: View {
    
    var title: String
    var titleFont: Font = .largeTitle
    var titleFontWeight: Font.Weight = .bold
    
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                Text(title)
                    .font(titleFont)
                    .fontWeight(titleFontWeight)
                    .foregroundStyle(AppColors.textContrast)
                    .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
            }
            .padding(.horizontal, 33)
            .padding(.vertical, 23)
            .background(AppColors.primary)
            .clipShape(RoundedRectangle(cornerRadius: 50))
            .foregroundStyle(AppColors.primary)
            .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
            .overlay(
                RoundedRectangle(cornerRadius: 50)
                    .inset(by: 2.5)
                    .stroke(AppColors.secondary, lineWidth: 5)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

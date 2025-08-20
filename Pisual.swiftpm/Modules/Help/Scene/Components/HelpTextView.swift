//
//  HelpTextView.swift
//  Pisual
//
//  Created by Lucky on 19/02/25.
//

import SwiftUI

struct HelpTextView: View {
    
    let title: String
    let description: String
    
    let descriptionHeight: CGFloat
    
    var body: some View {
        VStack(spacing: 0) { 
            Text(title)
                .frame(maxWidth: .infinity, maxHeight: 34, alignment: .leading)
                .font(.title)
                .fontWeight(.heavy)
                .foregroundStyle(AppColors.textPrimary)
            
            Text(description)
                .frame(maxWidth: .infinity, maxHeight: descriptionHeight, alignment: .leading)
                .font(.title)
                .fontWeight(.regular)
                .foregroundStyle(AppColors.textPrimary)
                .padding(.leading, 25)
        }
    }
}

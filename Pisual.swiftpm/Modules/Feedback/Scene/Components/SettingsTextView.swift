//
//  SettingsTextView.swift
//  Pisual
//
//  Created by Lucky on 18/02/25.
//

import SwiftUI

struct SettingsTextView: View {
    
    let title: String
    let values: String
    
    var body: some View {
        HStack(spacing: 0) { 
            Text(title)
                .frame(maxWidth: 108, maxHeight: 25, alignment: .leading)
                .font(.title3)
                .fontWeight(.heavy)
                .foregroundStyle(AppColors.textPrimary)
            
            Text(": \(values)")
                .frame(maxWidth: .infinity, maxHeight: 25, alignment: .leading)
                .font(.title3)
                .fontWeight(.regular)
                .foregroundStyle(AppColors.textPrimary)
        }
    }
}

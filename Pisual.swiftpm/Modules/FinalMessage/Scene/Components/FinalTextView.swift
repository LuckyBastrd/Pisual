//
//  FinalTextView.swift
//  Pisual
//
//  Created by Lucky on 19/02/25.
//

import SwiftUI

struct FinalTextView: View {
    
    let text: Text
    let frameHeight: CGFloat
    let alignment: Alignment
    
    var body: some View {
        text
            .frame(maxWidth: .infinity, maxHeight: frameHeight, alignment: alignment)
            .font(.title)
            .foregroundStyle(AppColors.textPrimary)
    }
}

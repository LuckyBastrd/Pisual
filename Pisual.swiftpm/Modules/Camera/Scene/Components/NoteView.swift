//
//  NoteView.swift
//  Pisual
//
//  Created by Lucky on 17/02/25.
//

import SwiftUI

struct NoteView: View {
    
    @ObservedObject var learningProgressManager: LearningProgressManager
    
    var body: some View {
        VStack(spacing: 7) {
            Text("Note: ")
                .frame(maxWidth: .infinity, maxHeight: 34, alignment: .leading)
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(AppColors.textPrimary)
            
            if let keyword = NoteKeyword(rawValue: learningProgressManager.currentPhase.name) {
                Text(Note.noteFor(keyword: keyword) ?? "Note not found")
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .font(.title)
                    .fontWeight(.regular)
                    .foregroundStyle(AppColors.textPrimary)
            }
        }
        .padding(.horizontal, 17)
    }
}

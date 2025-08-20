//
//  FinalMessageView.swift
//  Pisual
//
//  Created by Lucky on 19/02/25.
//

import SwiftUI

struct FinalMessageView: View {
    
    @EnvironmentObject var navigationManager: NavigationManager
    
    var body: some View {
        VStack(spacing: 0) { 
            VStack(spacing: 0) { 
                VStack(spacing: 47) { 
                    VStack(spacing: 33) {
                        Text("The End of This Lesson, The Beginning of Your Journey")
                            .frame(maxWidth: .infinity, maxHeight: 41, alignment: .center)
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .foregroundStyle(AppColors.textPrimary)
                        
                        VStack(spacing: 23) {
                            FinalTextView(
                                text:
                                    Text("Congratulations! You’ve made it to the end.")
                                        .bold()
                                    +
                                    Text(" While this game simplifies how cameras work, I hope it has given you a solid foundation in the exposure triangle. In reality, photography is more than just numbers, settings, and rules—it’s about the feeling you capture and the reason behind every adjustment you make."),
                                frameHeight: 136,
                                alignment: .topLeading
                            )
                            
                            FinalTextView(
                                text:
                                    Text("When you take a photo in real life, don’t just change your settings because they seem ‘correct.’")
                                    +
                                    Text(" Why am I choosing this shutter speed? What does this aperture do for my subject? Does this ISO help tell my story?")
                                        .italic()
                                    +
                                    Text(" Every choice you make should serve a purpose—whether it's freezing motion, creating dreamy bokeh, or embracing grain for a nostalgic feel."),
                                frameHeight: 136,
                                alignment: .topLeading
                            )
                            
                            FinalTextView(
                                text:
                                    Text("But beyond all the technicalities, photography is about emotions, memories, and perspectives. A perfectly exposed image can still feel empty if there’s no thought behind it, while an imperfect shot can be powerful if it captures the right moment. The light, the shadows, the composition—all of it comes together to express something unique to you."),
                                frameHeight: 136,
                                alignment: .topLeading
                            )
                            
                            FinalTextView(
                                text:
                                    Text("This game has given you the basics, but your real learning begins when you pick up a camera and start experimenting. So go out, take photos, make mistakes, and most importantly—capture moments that truly matter to you."),
                                frameHeight: 102,
                                alignment: .topLeading
                            )
                        }
                        
                        Text("Happy shooting, and may every click of your shutter tell a story worth remembering!")
                            .frame(maxWidth: .infinity, maxHeight: 28, alignment: .leading)
                            .font(.title2)
                            .fontWeight(.heavy)
                            .foregroundStyle(AppColors.textPrimary)
                    }
                    
                    CustomRoundedRectangleButtonView(
                        title: "THAT’S A WRAP!",
                        titleFont: .title2,
                        titleFontWeight: .heavy
                    ) { 
                        navigationManager.goToRoot()
                    }
                }
                .padding(.vertical, 45)
                .padding(.horizontal, 25)
            }
            .frame(maxWidth: .infinity, maxHeight: 933)
            .background(AppColors.textContrast)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(AppColors.textPrimary, lineWidth: 5)
            )
            .padding(.horizontal, 33)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(AppColors.neutral)
        .navigationBarBackButtonHidden(true)
    }
}

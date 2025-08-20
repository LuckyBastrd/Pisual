//import SwiftUI
//
//struct CustomSliderView: View {
//    
//    @Binding var selectedIndex: Int
//    
//    let title: String
//    
//    let leftImage: Image
//    let leftImageColor: Color
//    
//    let rightImage: Image
//    let rightImageColor: Color
//    
//    let values: [Double]
//    let labelFormatter: (Double) -> String
//    
//    @State private var feedbackGenerator = UISelectionFeedbackGenerator()
//    
//    var body: some View {
//        VStack(spacing: 0) {
//            // Title row with left and right images
//            HStack(spacing: 0) {
//                leftImage
//                    .frame(width: 41, height: 41)
//                    .font(.title)
//                    .fontWeight(.bold)
//                    .foregroundColor(leftImageColor)
//                
//                Spacer()
//                
//                Text(title)
//                    .font(.title)
//                    .fontWeight(.bold)
//                    .foregroundColor(AppColors.textPrimary)
//                
//                Spacer()
//                
//                rightImage
//                    .frame(width: 41, height: 41)
//                    .font(.title)
//                    .fontWeight(.bold)
//                    .foregroundColor(rightImageColor)
//            }
//            .padding(.horizontal, 17)
//            
//            GeometryReader { geometry in
//                let fullTrackWidth = geometry.size.width
//                let knobSize: CGFloat = 27
//                let stepCount = values.count - 1
//                let effectiveTrackWidth = fullTrackWidth - knobSize
//                let stepWidth = effectiveTrackWidth / CGFloat(stepCount)
//                
//                VStack(spacing: 0) {
//                    // Slider track and knob
//                    ZStack(alignment: .leading) {
//                        // Track background
//                        RoundedRectangle(cornerRadius: 20)
//                            .fill(AppColors.secondary)
//                            .frame(height: 17)
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 20)
//                                    .stroke(AppColors.textPrimary, lineWidth: 1)
//                            )
//                        
//                        // Draggable knob as a circle with shadow
//                        Circle()
//                            .fill(AppColors.primary)
//                            .frame(width: knobSize, height: knobSize)
//                            .overlay(
//                                Circle()
//                                    .stroke(AppColors.secondary, lineWidth: 2)
//                            )
//                        // Place the knob so its center is at knobSize/2 + (selectedIndex * stepWidth)
//                            .offset(x: (knobSize/2 + CGFloat(selectedIndex) * stepWidth) - knobSize/2)
//                            .gesture(
//                                DragGesture()
//                                    .onChanged { gesture in
//                                        let adjustedX = min(max(0, gesture.location.x - knobSize/2), effectiveTrackWidth)
//                                        let newIndex = Int((adjustedX / stepWidth).rounded())
//                                        if newIndex != selectedIndex {
//                                            if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == nil {
//                                                feedbackGenerator.selectionChanged()
//                                            }
//                                            selectedIndex = newIndex
//                                        }
//                                    }
//                            )
//                    }
//                    .frame(height: 27)
//                    
//                    // Tick marks directly below the slider bar
//                    ZStack {
//                        ForEach(0..<values.count, id: \.self) { index in
//                            Rectangle()
//                                .fill(index == selectedIndex ? AppColors.primary : AppColors.textPrimary)
//                                .frame(width: 2, height: 13)
//                                .position(x: knobSize/2 + CGFloat(index) * stepWidth, y: 5)
//                        }
//                    }
//                    .frame(height: 13)
//                    
//                    // Labels directly below the tick marks, aligned with each tick
//                    ZStack {
//                        ForEach(0..<values.count, id: \.self) { index in
//                            Text(labelFormatter(values[index]))
//                                .font(.body)
//                                .fontWeight(.regular)
//                                .foregroundColor(index == selectedIndex ? AppColors.primary : AppColors.textPrimary)
//                                .position(x: knobSize/2 + CGFloat(index) * stepWidth, y: 10)
//                        }
//                    }
//                }
//            }
//            .frame(height: 70)
//            .padding(.horizontal, 58)
//        }
//        .onAppear {
//            feedbackGenerator.prepare()
//        }
//    }
//}

import SwiftUI

struct CustomSliderView: View {
    
    @Binding var selectedIndex: Int
    
    let title: String
    
    let leftImage: Image
    let leftImageColor: Color
    
    let rightImage: Image
    let rightImageColor: Color
    
    let values: [Double]
    let labelFormatter: (Double) -> String
    
    var body: some View {
        VStack(spacing: 0) {
            // Title row with left and right images
            HStack(spacing: 0) {
                leftImage
                    .frame(width: 41, height: 41)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(leftImageColor)
                
                Spacer()
                
                Text(title)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(AppColors.textPrimary)
                
                Spacer()
                
                rightImage
                    .frame(width: 41, height: 41)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(rightImageColor)
            }
            .padding(.horizontal, 17)
            
            GeometryReader { geometry in
                let fullTrackWidth = geometry.size.width
                let knobSize: CGFloat = 27
                let stepCount = values.count - 1
                let effectiveTrackWidth = fullTrackWidth - knobSize
                let stepWidth = effectiveTrackWidth / CGFloat(stepCount)
                
                VStack(spacing: 0) {
                    // Slider track and knob
                    ZStack(alignment: .leading) {
                        // Track background
                        RoundedRectangle(cornerRadius: 20)
                            .fill(AppColors.secondary)
                            .frame(height: 17)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(AppColors.textPrimary, lineWidth: 1)
                            )
                        
                        // Draggable knob as a circle with shadow
                        Circle()
                            .fill(AppColors.primary)
                            .frame(width: knobSize, height: knobSize)
                            .overlay(
                                Circle()
                                    .stroke(AppColors.secondary, lineWidth: 2)
                            )
                        // Place the knob so its center is at knobSize/2 + (selectedIndex * stepWidth)
                            .offset(x: (knobSize/2 + CGFloat(selectedIndex) * stepWidth) - knobSize/2)
                            .gesture(
                                DragGesture()
                                    .onChanged { gesture in
                                        let adjustedX = min(max(0, gesture.location.x - knobSize/2), effectiveTrackWidth)
                                        let newIndex = Int((adjustedX / stepWidth).rounded())
                                        if newIndex != selectedIndex {
                                            if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == nil {
                                                let generator = UISelectionFeedbackGenerator()
                                                generator.prepare()
                                                generator.selectionChanged()
                                            }
                                            
                                            selectedIndex = newIndex
                                        }
                                    }
                            )
                    }
                    .frame(height: 27)
                    
                    // Tick marks directly below the slider bar
                    ZStack {
                        ForEach(0..<values.count, id: \.self) { index in
                            Rectangle()
                                .fill(index == selectedIndex ? AppColors.primary : AppColors.textPrimary)
                                .frame(width: 2, height: 13)
                                .position(x: knobSize/2 + CGFloat(index) * stepWidth, y: 5)
                        }
                    }
                    .frame(height: 13)
                    
                    // Labels directly below the tick marks, aligned with each tick
                    ZStack {
                        ForEach(0..<values.count, id: \.self) { index in
                            Text(labelFormatter(values[index]))
                                .font(.body)
                                .fontWeight(.regular)
                                .foregroundColor(index == selectedIndex ? AppColors.primary : AppColors.textPrimary)
                                .position(x: knobSize/2 + CGFloat(index) * stepWidth, y: 10)
                        }
                    }
                }
            }
            .frame(height: 70)
            .padding(.horizontal, 58)
        }
    }
}

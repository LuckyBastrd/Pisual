//
//  DropDownPickerView.swift
//  Pisual
//
//  Created by Lucky on 20/02/25.
//

import SwiftUI

enum DropDownPickerState {
    case top
    case bottom
}

struct DropDownPickerView: View {
    
    @Binding var selection: Double?
    
    var state: DropDownPickerState = .top
    var options: [(String, Double)]
    var maxWidth: CGFloat = 180
    var isWildMode: Bool
    
    @State var showDropdown = false
    
    @SceneStorage("drop_down_zindex") private var index = 1000.0
    @State var zindex = 1000.0
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            VStack(spacing: 0) {
                
                
                if state == .top && showDropdown {
                    OptionsView()
                }
                
                HStack {
                    Text(selection == nil ? "Select Time" : options.first(where: { $0.1 == selection })?.0 ?? "Select Time")
                        .foregroundColor(selection != nil ? AppColors.textContrast : AppColors.neutral)
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Image(systemName: state == .top ? "chevron.up" : "chevron.down")
                        .font(.title3)
                        .fontWeight(.heavy)
                        .foregroundColor(AppColors.textContrast)
                        .rotationEffect(.degrees(showDropdown ? -180 : 0))
                        .opacity(isWildMode ? 1 : 0.5)
                }
                .padding(.horizontal, 15)
                .frame(width: 182, height: 44)
                .background(AppColors.primary)
                .contentShape(.rect)
                .onTapGesture {
                    index += 1
                    zindex = index
                    withAnimation(.snappy) {
                        showDropdown.toggle()
                    }
                }
                .zIndex(10)
                
                if state == .bottom && showDropdown {
                    OptionsView()
                }
            }
            .clipped()
            .background(AppColors.primary)
            .cornerRadius(10)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(AppColors.secondary, lineWidth: 3)
            }
            .frame(height: size.height, alignment: state == .top ? .bottom : .top)
            
        }
        .frame(width: maxWidth, height: 50)
        .zIndex(zindex)
    }
    
    
    func OptionsView() -> some View {
        VStack(spacing: 0) {
            ForEach(options, id: \.1) { option in
                HStack {
                    Text(option.0)
                        .fontWeight(.bold)
                    Spacer()
                    Image(systemName: "checkmark")
                        .opacity(selection == option.1 ? 1 : 0)
                }
                .foregroundStyle(selection == option.1 ? AppColors.textContrast : AppColors.neutral)
                .animation(.none, value: selection)
                .frame(height: 40)
                .contentShape(Rectangle())
                .padding(.horizontal, 15)
                .onTapGesture {
                    withAnimation(.snappy) {
                        selection = option.1
                        showDropdown.toggle()
                    }
                }
            }
        }
        .transition(.move(edge: state == .top ? .bottom : .top))
        .zIndex(1)
    }
}

//
//  CornerRadiusModifier.swift
//  Pisual
//
//  Created by Lucky on 17/02/25.
//

import SwiftUI

struct CornerRadiusModifier: ViewModifier {
    var topLeft: CGFloat
    var topRight: CGFloat
    var bottomLeft: CGFloat
    var bottomRight: CGFloat

    func body(content: Content) -> some View {
        content
            .clipShape(CustomRoundedCorners(topLeft: topLeft,
                                       topRight: topRight,
                                       bottomLeft: bottomLeft,
                                       bottomRight: bottomRight))
    }
}

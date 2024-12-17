//
//  FontModifiers.swift
//  Weather
//
//  Created by Razvan Copaciu on 17.12.2024.
//

import SwiftUI

extension Font {
    static func appFont(size: CGFloat) -> Font {
        .custom("Poppins-Medium", size: size)
    }
}

struct FontModifier: ViewModifier {
    var size: CGFloat

    func body(content: Content) -> some View {
        content
            .font(.appFont(size: size))
    }
}

extension View {
    func appFont(size: CGFloat) -> some View {
        modifier(FontModifier(size: size))
    }
}

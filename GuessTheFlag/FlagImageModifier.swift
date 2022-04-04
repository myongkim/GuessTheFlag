//
//  FlagImageModifier.swift
//  GuessTheFlag
//
//  Created by Isaac Kim on 4/4/22.
//

import SwiftUI

struct FontModifier: ViewModifier {
    var text: String
    
    func body(content: Content) -> some View {
        content
        
        Text(text)
            .foregroundColor(.white)
            .font(.largeTitle.weight(.bold))
    }
}

extension View {
    func titleModifier(with text: String) -> some View {
        modifier(FontModifier(text: text))
        
    }
}

struct TitleModifier: ViewModifier{
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

extension View {
    func title() -> some View {
        modifier(TitleModifier())
    }
}

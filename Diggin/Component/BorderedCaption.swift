//
//  BorderedCaption.swift
//  Diggin
//
//  Created by 김승찬 on 2023/12/02.
//

import SwiftUI

struct BorderedCaption: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 24))
            .padding(20)
            .foregroundColor(.black)
    }
}

extension View {
    func borderedCaption() -> some View {
        modifier(BorderedCaption())
    }
    
    func makeTitleLabel() -> some View {
        self.font(.title)
            .padding(20)
    }
}

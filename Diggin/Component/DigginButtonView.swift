//
//  DigginButtonView.swift
//  Diggin
//
//  Created by 김승찬 on 2023/12/05.
//

import SwiftUI

public struct DigginButtonView<Content: View>: View {
    let content: Content
    let action: () -> Void
    let title: String
    
    @State private var isSelected: Bool = false
    
    public init(
        @ViewBuilder content: () -> Content,
        action: @escaping () -> Void,
        title: String
    ) {
        self.content = content()
        self.action = action
        self.title = title
    }
    
    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .stroke(isSelected ? Color.green : Color.red, lineWidth: 2)
                .overlay(content)
            VStack {
                HStack {
                    Spacer()
                    
                    Button(action: {
                        isSelected.toggle()
                        action()
                    }, label: {
                        Text(title)
                            .foregroundColor(.black)
                        
                    })
                    Spacer()
                }
            }
        }
    }
}

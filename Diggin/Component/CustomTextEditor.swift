//
//  CustomTextEditor.swift
//  Diggin
//
//  Created by 김승찬 on 2023/12/07.
//

import SwiftUI

struct CustomTextEditor: View {
    let placeholder: String
    @Binding var text: String
    let internalPadding: CGFloat = 5
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(.white)
                    .padding(EdgeInsets(top: 7, leading: 4, bottom: 0, trailing: 0))
                    .padding(internalPadding)
            }
            TextEditor(text: $text)
                .padding(internalPadding)
                .cornerRadius(10)
        }
        .overlay(
                 RoundedRectangle(cornerRadius: 10)
                   .stroke(Color.black, lineWidth: 3)
                 )
        .onAppear() {
            UITextView.appearance().backgroundColor = .clear
        }.onDisappear() {
            UITextView.appearance().backgroundColor = nil
        }
    }
}

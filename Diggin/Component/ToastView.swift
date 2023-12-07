//
//  ToastView.swift
//  Diggin
//
//  Created by 김승찬 on 2023/12/02.
//

import SwiftUI

struct ToastView<Content: View>: View {
    let content: Content
    let isShowing: Binding<Bool>

    init(isShowing: Binding<Bool>, @ViewBuilder content: () -> Content) {
        self.isShowing = isShowing
        self.content = content()
    }

    var body: some View {
        ZStack(alignment: .center) {
            content
                .padding()
                .background(Color.black)
                .foregroundColor(Color.stemGreen)
                .font(.suitSB(13))
                .cornerRadius(10)
                .opacity(isShowing.wrappedValue ? 1.0 : 0.0)
                .scaleEffect(isShowing.wrappedValue ? 1.0 : 0.5)
                .animation(.spring())
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .onTapGesture {
            withAnimation {
                isShowing.wrappedValue.toggle()
            }
        }
    }
}

extension View {
    func toast<Content: View>(isShowing: Binding<Bool>, @ViewBuilder content: () -> Content) -> some View {
        ToastView(isShowing: isShowing, content: content)
    }
}

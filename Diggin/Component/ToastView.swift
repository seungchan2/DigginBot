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
                .background(Color.gray)
                .foregroundColor(Color.primary)
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

struct ContentView: View {
    @State private var showToast: Bool = false

    var body: some View {
        ZStack {
            VStack {
                Button("Show Toast") {
                    showToast.toggle()
                }
            }
            .toast(isShowing: $showToast) {
                Text("This is a toast message.")
            }
        }
        .padding()

    }
}

extension View {
    func toast<Content: View>(isShowing: Binding<Bool>, @ViewBuilder content: () -> Content) -> some View {
        ToastView(isShowing: isShowing, content: content)
    }
}

//
//  ChatItemView.swift
//  Diggin
//
//  Created by 김승찬 on 2023/12/05.
//

import SwiftUI

struct ChatItemView: View {
    let message: String
    let direction: ChatItemDirection
    let date: Date
    
    var body: some View {
        HStack(alignment: .bottom) {
            if direction == .right {
                Spacer()
                dateTextView
                messageView
            }
            
            if direction == .left {
                gptView
                Spacer()
            }
        }
        .padding(.horizontal, 20)
    }
    
    var dateTextView: some View {
        Text(date.formattedTime)
            .font(.system(size: 10))
            .foregroundColor(.white)
    }
    
    var messageView: some View {
        Text(message)
            .font(.suitM(15))
            .foregroundColor(Color.blackSub)
            .padding(.vertical, 9)
            .padding(.horizontal, 10)
            .background(Color.stemGreen)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
    var gptView: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Image("Avatar")
                    .resizable()
                    .frame(width: 35, height: 35)
                    .cornerRadius(17.5)
                    .aspectRatio(contentMode: .fill)

                Text("DigginBot")
                    .foregroundColor(.white)
                    .font(.suitB(21))
                }
            
            HStack {
                Image(systemName: "heart.fill")
                    .foregroundColor(.black)
                    .frame(width: 35, height: 35)
                
                VStack(spacing: 0) {
                    Text(message)
                        .foregroundColor(.white)
                        .font(.suitM(15))
                }
            }
        }
    }
}

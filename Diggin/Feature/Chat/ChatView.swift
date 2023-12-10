//
//  ChatView.swift
//  Diggin
//
//  Created by 김승찬 on 2023/12/04.
//

import SwiftUI
import SpriteKit

class SnowScene: SKScene {
    override func didMove(to view: SKView) {
        addSnow()
    }
    
    func addSnow() {
        let emitterNode = SKEmitterNode(fileNamed: "SnowParticle.sks")
        emitterNode?.position = CGPoint(x: size.width / 3, y: size.height)
        addChild(emitterNode!)
    }
}

struct ChatView: View {
    @StateObject var viewModel: ChatViewModel
    @FocusState var isFocused: Bool
    
    var scene: SKScene {
        let scene = SnowScene()
        scene.size = CGSize(width: 216, height: 216)
        scene.scaleMode = .fill
        scene.backgroundColor = .black
        return scene
    }
    
    var body: some View {
        ZStack {
            SpriteView(scene: self.scene)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading) {
                Text("DigginBot에게 음악 추천 받아보세요!")
                    .font(.suitB(17))
                    .padding(.leading, 20)
                    .foregroundColor(.white)
                
                ScrollView {
                    contentView
                }
                .background(Color.clear)
                .navigationBarBackButtonHidden()
                .onAppear {
                    viewModel.send(action: .load)
                }
            }
        }
    }
    
    var contentView: some View {
        ForEach(viewModel.chatDataList) { chatData in
            Section {
                ForEach(chatData.chats) { chat in
                    ChatItemView(message: chat.message ?? "", direction: chat.direction, date: chat.date)
                }
            } header: {
                headerView(dateStr: chatData.dateStr)
            }
        }
    }
    
    func headerView(dateStr: String) -> some View {
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
                .background(Color.clear)
                .cornerRadius(10)
            Text(dateStr)
                .padding(.top, 10)
                .font(.suitB(15))
                .foregroundColor(Color.white)
        }
    }
}

struct ChatItemView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(viewModel: ChatViewModel(repository: ChatDBRepository()))
    }
}

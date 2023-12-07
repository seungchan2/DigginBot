//
//  WriteView.swift
//  Diggin
//
//  Created by 김승찬 on 2023/12/06.
//

import Combine
import SwiftUI
import PhotosUI

struct WriteView: View {
    @StateObject var viewModel: WriteViewModel
    @Environment(\.presentationMode) var presentationMode
    @FocusState var isFocused: Bool
    @State private var isRightButtonEnabled: Bool = false

    var body: some View {
        
        VStack() {
            CustomNavigationBar(leftButtonAction: {
                presentationMode.wrappedValue.dismiss()
            }, rightButtonAction: {
                viewModel.send(action: .addMusicList(title: viewModel.titleText,
                                                     artist: viewModel.artistText,
                                                     content: viewModel.contentText))
                presentationMode.wrappedValue.dismiss()
            }, isRightButtonEnabled: isRightButtonEnabled)
            .onReceive(viewModel.isButtonEnabledPublisher) { isEnabled in
                self.isRightButtonEnabled = isEnabled
            }
            .padding(.horizontal, 0)
            
            PhotosPicker(selection: $viewModel.imageSelection, matching: .images) {
                if let image = UIImage(data: viewModel.imageData) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 120, height: 120)
                        .clipped()
                        .padding(.top, 50)
                } else {
                    Image("Avatar")
                        .resizable()
                        .frame(width: 120, height: 120)
                        .padding(.top, 50)
                }
            }
            
            HStack {
                Text("아티스트")
                    .foregroundColor(.white)
                    .font(.suitB(16))
                TextField("", text: $viewModel.artistText)
                    .font(.system(size: 14))
                    .foregroundColor(.white)
                    .focused($isFocused)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 10)
                    .background(Color.black)
                    .cornerRadius(10)
                    .padding(.leading, 20)
                    .padding(.trailing, 20)
            }
            .padding(.leading, 20)
            
            HStack {
                Text("오늘의 기분")
                    .foregroundColor(.white)
                    .font(.suitB(16))
                
                TextField("", text: $viewModel.titleText)
                    .font(.system(size: 14))
                    .foregroundColor(.white)
                    .focused($isFocused)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 10)
                    .background(Color.black)
                    .cornerRadius(10)
                
                    .padding(.leading, 20)
                    .padding(.trailing, 20)
            }
            .padding(.leading, 20)
            
            VStack(alignment: .leading) {
                Text("한줄일기")
                    .font(.suitB(16))
                    .foregroundColor(.white)
                    .padding(.top, 8)
                
                CustomTextEditor(placeholder: "입력", text: $viewModel.contentText)
                    .font(.system(size: 14))
                    .scrollContentBackground(.hidden)
                    .foregroundColor(.white)
                    .background(Color.black)
                    .focused($isFocused)
                    .padding(.vertical, 8)
                    .cornerRadius(10)
                    .padding(.trailing, 20)
            }
            .padding(.leading, 20)
            
            Spacer()
        }
        .background(Color.blackSub)
        .navigationBarBackButtonHidden()
    }
}


struct WriteView_Previews: PreviewProvider {
    static var previews: some View {
        WriteView(viewModel: WriteViewModel(repository: WriteDBRepository(), photoService: PhotoPickerService()))
    }
}


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
        }.onAppear() {
            UITextView.appearance().backgroundColor = .clear
        }.onDisappear() {
            UITextView.appearance().backgroundColor = nil
        }
    }
}

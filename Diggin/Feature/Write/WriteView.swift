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
    @State private var showToast: Bool = false
    
    var body: some View {
        ZStack {
            VStack() {
                CustomNavigationBar(leftButtonAction: {
                    presentationMode.wrappedValue.dismiss()
                }, rightButtonAction: {
                    
                    if !isRightButtonEnabled {
                        showToast(message: "")
                    } else {
                        viewModel.send(action: .addMusicList(title: viewModel.titleText,
                                                             artist: viewModel.artistText,
                                                             content: viewModel.contentText))
                        presentationMode.wrappedValue.dismiss()
                    }
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
                            .padding(.top, 30)
                            .cornerRadius(10)
                    } else {
                        Image("Logo")
                            .resizable()
                            .frame(width: 120, height: 120)
                            .padding(.top, 30)
                            .cornerRadius(10)
                    }
                }
                
                HStack {
                    Text("오늘의 음악")
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
                
                VStack(alignment: .leading) {
                    Text("한 줄 일기")
                        .font(.suitB(16))
                        .foregroundColor(.white)
                        .padding(.top, 8)
                    
                    CustomTextEditor(placeholder: "", text: $viewModel.contentText)
                        .font(.system(size: 14))
                        .scrollContentBackground(.hidden)
                        .foregroundColor(.white)
                        .background(Color.black)
                        .focused($isFocused)
                        .padding(.vertical, 8)
                        .padding(.trailing, 20)
                        .frame(height: 200)
                        .onTapGesture {
                            self.endTextEditing()
                        }
                }
                .padding(.leading, 20)
                
                Spacer()
            }
            
            if showToast {
                ToastView(isShowing: $showToast) {
                    Text("오늘의 사진, 음악, 아티스트, 일기를 다 작성하셨나요?")
                }
                .transition(.move(edge: .bottom))
            }
        }
        .background(Color.blackSub)
        .navigationBarBackButtonHidden()
    }
    
    private func showToast(message: String) {
        self.showToast = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            withAnimation {
                self.showToast = false
            }
        }
    }
}

struct WriteView_Previews: PreviewProvider {
    static var previews: some View {
        WriteView(viewModel: WriteViewModel(repository: WriteDBRepository(), photoService: PhotoPickerService()))
    }
}

extension View {
    func endTextEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

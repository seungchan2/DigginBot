//
//  WriteView.swift
//  Diggin
//
//  Created by 김승찬 on 2023/12/06.
//

import SwiftUI

struct WriteView: View {
    @StateObject var viewModel: WriteViewModel
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
            VStack(spacing: 16) {
                Image("Avatar")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .padding(.top, 50)
                
                HStack {
                    Text("아티스트")
                        .foregroundColor(.white)
                        .font(.suitB(16))
                    TextField("", text: $viewModel.artistText)
                }
                .padding(.leading, 20)
                
                HStack {
                    Text("오늘의 기분")
                        .foregroundColor(.white)
                        .font(.suitB(16))

                    TextField("", text: $viewModel.titleText)
                }
                .padding(.leading, 20)
                
                Text("한줄일기")
                    .font(.suitB(16))
                    .foregroundColor(.white)
                    .padding(.top, 8)
                
                TextEditor(text: $viewModel.contentText)
                    .font(.system(size: 14))
                    .foregroundColor(Color.gray)
                    .frame(height: 100)
                    .padding(8)
                
                Spacer()
            }
            .background(Color.blackSub)
       
            .navigationBarItems(
                leading: Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .imageScale(.medium) // Adjust the size by changing this value
                        .frame(width: 40, height: 40)
                        .foregroundColor(.white)
                },
                trailing: Button(action: {
                    print("완료 버튼 눌림")
                    viewModel.send(action: .addMusicList(title: viewModel.titleText,
                                                         artist: viewModel.artistText,
                                                         content: viewModel.contentText))
                    presentationMode.wrappedValue.dismiss()

                }) {
                    Text("완료")
                        .font(.headline)
                        .foregroundColor(.white)
                }
            ).navigationBarBackButtonHidden()
        }
    }
    

struct WriteView_Previews: PreviewProvider {
    static var previews: some View {
        WriteView(viewModel: WriteViewModel(repository: WriteDBRepository()))
    }
}


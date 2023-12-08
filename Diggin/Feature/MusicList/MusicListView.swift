//
//  MusicListView.swift
//  Diggin
//
//  Created by 김승찬 on 2023/12/05.
//

import SwiftUI

struct MusicListView: View {
    @StateObject var viewModel: MusicListViewModel
    
    var body: some View {
        if viewModel.writeDataList.isEmpty {
            ScrollView {
                emptyView
            }
        } else {
            ScrollView {
                contentView
            }
            .onAppear {
                viewModel.send(action: .load)
            }
        }
    }
    
    var contentView: some View {
        ForEach(viewModel.writeDataList) { writeData in
            MusicListItemView(title: writeData.title,
                              artist: writeData.artist,
                              content: writeData.content,
                              date: writeData.date,
                              image: writeData.musicImage)
            .padding(.horizontal, 10)
        }
    }
    
    var emptyView: some View {
        Text("일기를 작성해주세요 ㅠ.ㅠ")
            .foregroundColor(.white)
            .padding(.top, 10)
    }
}

struct MusicListItemView: View {
    let title: String
    let artist: String
    let content: String
    let date: Date
    let image: Data
    
    var body: some View {
        HStack(alignment: .top) {
            if let image = UIImage(data: image) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipped()
                    .cornerRadius(10)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .foregroundColor(.white)
                    .font(.suitB(15))
                    .lineLimit(1)
                
                Text(artist)
                    .foregroundColor(.white)
                    .font(.suitSB(13))
                    .lineLimit(1)
                
                Text(content)
                    .foregroundColor(.white)
                    .font(.suitM(13))
                    .lineLimit(2)
            }
            .padding(.trailing, 10)
            
            Spacer()
            
            dateTextView
                .padding(.trailing, 20)
        }
        .padding(.horizontal, 10)
        .padding(.top, 10)
    }
    
    var dateTextView: some View {
        Text(date.formattedDay)
            .font(.suitM(13))
            .foregroundColor(.white)
    }
}

struct MusicListView_Previews: PreviewProvider {
    static var previews: some View {
        MusicListView(viewModel: MusicListViewModel(repository: WriteDBRepository()))
    }
}


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
            ScrollView {
                contentView
            }
        }
    
    var contentView: some View {
        ForEach(viewModel.writeDataList) { writeData in
            MusicListItemView(title: writeData.title,
                              artist: writeData.artist,
                              content: writeData.content,
                              date: writeData.date)
        }
    }
}

struct MusicListItemView: View {
    let title: String
    let artist: String
    let content: String
    let date: Date

    var body: some View {
        VStack {
            Text(title)
                .foregroundColor(.white)
            Text(artist)
                .foregroundColor(.white)

            Text(content)
                .foregroundColor(.white)

            dateTextView
        }
    }
    
    var dateTextView: some View {
        Text(date.formattedTime)
            .font(.system(size: 10))
            .foregroundColor(.white)
    }
}

struct MusicListView_Previews: PreviewProvider {
    static var previews: some View {
        MusicListView(viewModel: MusicListViewModel(repository: WriteDBRepository()))
    }
}


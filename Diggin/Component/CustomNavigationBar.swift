//
//  CustomNavigationBar.swift
//  Diggin
//
//  Created by 김승찬 on 2023/11/30.
//

import SwiftUI

struct CustomNavigationBar: View {
    let leftButtonAction: () -> Void
    let rightButtonAction: () -> Void
    let isRightButtonEnabled: Bool
    
    init(
        leftButtonAction: @escaping () -> Void = {},
        rightButtonAction: @escaping () -> Void = {},
        isRightButtonEnabled: Bool = false
    ) {
        self.leftButtonAction = leftButtonAction
        self.rightButtonAction = rightButtonAction
        self.isRightButtonEnabled = isRightButtonEnabled
    }
    
    var body: some View {
        HStack {
            Button(
                action: leftButtonAction,
                label: {
                    Image(systemName: "chevron.left")
                        .imageScale(.medium)
                }
            )
            .foregroundColor(.white)
            .frame(width: 40, height: 40)
            
            Spacer()
            
            Text("글 작성하기")
                .foregroundColor(.white)
                .font(.suitB(18))
            
            Spacer()
            
            Button(
                action: {
                    if isRightButtonEnabled {
                        rightButtonAction()
                    }
                } ,
                label: {
                    Text("완료")
                        .foregroundColor(.white)
                }
            )
            .foregroundColor(isRightButtonEnabled ? .white : .gray)
            .disabled(!isRightButtonEnabled)
        }
        .padding(.horizontal)
        .frame(width: UIScreen.main.bounds.width, height: 50)
        .background(Color.blackSub)
    }
}

struct CustomNavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavigationBar()
    }
}

//
//  FlowerDetailHeaderView.swift
//  BouquetApp
//
//  Created by ミズキ on 2022/09/19.
//

import SwiftUI

struct FlowerDetailHeaderView: View {

    @ObservedObject var viewModel: FlowerDetailViewModel
 
    var body: some View {
        HStack {
            Button {
                // もどる処理
            } label: {
                Image(systemName: "arrow.left")
                    .font(.system(size: 16,
                                  weight: .heavy))
                    .foregroundColor(.white)
                    .frame(width: 42,
                           height: 42)
                    .background {
                        RoundedRectangle(cornerRadius: 15,
                                         style: .continuous)
                            .fill(.white.opacity(0.2))
                    }
            }
            
            Spacer()
            
            Button {
                withAnimation(.easeInOut) {
                    viewModel.isVerticleLook.toggle()
                }
            } label: {
                Image(systemName: "arrow.left.and.right.righttriangle.left.righttriangle.right.fill")
                    .font(.system(size: 16,
                                  weight: .heavy))
                    .foregroundColor(.white)
                    .rotationEffect(.init(degrees: viewModel.isVerticleLook ? 0 : 90))
                    .frame(width: 42,
                           height: 42)
                    .background {
                        RoundedRectangle(cornerRadius: 15,
                                         style: .continuous)
                            .fill(.white.opacity(0.2))
                    }
            }
        }
    }
}

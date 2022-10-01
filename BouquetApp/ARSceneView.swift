//
//  ContentView.swift
//  BouquetApp
//
//  Created by ミズキ on 2022/09/17.
//
// 花束を作る画面。
// 送る画面
// 花を見れる画面
// Multiper Helper

import SwiftUI
import RealityKit

struct ARSceneView : View {
    @StateObject var viewModel: ARSceneViewModel = ARSceneViewModel()
    @EnvironmentObject var arSceneManager: ARSceneManager

    var body: some View {
        ZStack(alignment: .bottom) {
            
            MainARViewContainer(viewModel: viewModel)
            
            if !arSceneManager.isSelectedModel {
                HStack {
                    Spacer()
                    Button(action: {
                        viewModel.isTappedSendButton.toggle()
                    }, label: {
                        Image(systemName: "paperplane.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.white)
                    })
                    
                    Spacer()
                    
                    Button(action: {
                        viewModel.isShowFullModal.toggle()
                    }, label: {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.white)
                    })
                    Spacer()
                }
                .padding()
                .padding(.bottom, 10)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .statusBarHidden()
        .fullScreenCover(isPresented: $viewModel.isShowFullModal) {
            FlowerList(isShowFullModal: $viewModel.isShowFullModal)
        }
    }
}


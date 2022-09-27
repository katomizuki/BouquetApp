//
//  FlowerList.swift
//  BouquetApp
//
//  Created by ミズキ on 2022/09/19.
//

import SceneKit
import SwiftUI

struct FlowerDetail: View {
    @GestureState var offset: CGFloat = 0
    @StateObject  var viewModel: FlowerDetailViewModel
    @Environment(\.dismiss) var dismiss
    @Binding var isShowFullModal: Bool
    
    // MARK: View Properties
    var body: some View {
        NavigationView {
            ScrollView(.vertical,
                       showsIndicators: false) {
                VStack {
                    // MARK: - 3D Preview
                    CustomFlowerSceneView(scene: $viewModel.scene)
                        .frame(height: 350)
                        .padding(.top, -50)
                        .padding(.bottom, -15)
                        .zIndex(-10)
                    
                    CustomFlowerSeaker(offset: offset,
                                       viewModel: viewModel)
                    
                    PropertiesFlowerView(viewModel: viewModel,
                                         isShowFullModal: $isShowFullModal)
                }
                .padding()
            }
            .preferredColorScheme(.dark)
            
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    // もどる処理
                   dismiss()
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
            }
            ToolbarItem(placement: .navigationBarTrailing) {
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
}

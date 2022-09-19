//
//  FlowerList.swift
//  BouquetApp
//
//  Created by ミズキ on 2022/09/19.
//

import SceneKit
import SwiftUI

struct FlowerList: View {
    @GestureState var offset: CGFloat = 0
    @StateObject private var viewModel: FlowerDetailViewModel = FlowerDetailViewModel()
    
    // MARK: View Properties
    var body: some View {
        ScrollView(.vertical,
                   showsIndicators: false) {
            VStack {
                FlowerDetailHeaderView(viewModel: viewModel)
                // MARK: - 3D Preview
                CustomFlowerSceneView(scene: $viewModel.scene)
                    .frame(height: 350)
                    .padding(.top, -50)
                    .padding(.bottom, -15)
                    .zIndex(-10)
                
                CustomFlowerSeaker(offset: offset,
                                   viewModel: viewModel)
                
                PropertiesFlowerView()
            }
            .padding()
        }
        .preferredColorScheme(.dark)
    }
}

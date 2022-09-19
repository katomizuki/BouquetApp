//
//  FlowerList.swift
//  BouquetApp
//
//  Created by ミズキ on 2022/09/19.
//

import SceneKit
import SwiftUI

struct FlowerList: View {
    @State var scene: SCNScene? = .init(named: "satsuki.scn")
    @State var isVerticleLook: Bool = false
    // MARK: View Properties
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                HeaderView()
                // MARK: - 3D Preview
                CustomFlowerSceneView(scene: $scene)
                    .frame(height: 350)
                    .padding(.top, -50)
                    .padding(.bottom, -15)
                
                CustomSeeker()
            }
            .padding()
        }
        .preferredColorScheme(.dark)
    }
    
    @ViewBuilder
    func CustomSeeker() -> some View {
        GeometryReader { proxy in
            Rectangle()
                .trim(from: 0, to: 0.4)
                .stroke(.white, style: StrokeStyle(lineWidth: 2,
                                                   lineCap: .round,
                                                   lineJoin: .round,
                                                   miterLimit: 1,
                                                   dash: [3],
                                                   dashPhase: 1))
        }
    }
    
    
    @ViewBuilder
    func HeaderView() -> some View {
        HStack {
            Button {
                
            } label: {
               Image(systemName: "arrow.left")
                    .font(.system(size: 16, weight: .heavy))
                    .foregroundColor(.white)
                    .frame(width: 42, height: 42)
                    .background {
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .fill(.white.opacity(0.2))
                    }
            }
            Spacer()
            
            Button {
                withAnimation(.easeInOut) {
                    isVerticleLook.toggle()
                }
            } label: {
               Image(systemName: "arrow.left.and.right.righttriangle.left.righttriangle.right.fill")
                    .font(.system(size: 16, weight: .heavy))
                    .foregroundColor(.white)
                    .rotationEffect(.init(degrees: isVerticleLook ? 0 : 90))
                    .frame(width: 42, height: 42)
                    .background {
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .fill(.white.opacity(0.2))
                    }
            }
        }
    }
}

//
//  CustomFlowerSeaker.swift
//  BouquetApp
//
//  Created by ミズキ on 2022/09/19.
//

import SwiftUI
import SceneKit

struct CustomFlowerSeaker: View {
    @GestureState var offset: CGFloat
    @StateObject var viewModel: FlowerDetailViewModel
    
    var body: some View {
        GeometryReader { _ in
            Rectangle()
                .trim(from: 0, to: 0.474)
                .stroke(.linearGradient(colors:
                                            [
                                                .clear,
                                                .clear,
                                                .white.opacity(0.2),
                                                .white.opacity(0.6),
                                                .white,
                                                .white.opacity(0.6),
                                                .white.opacity(0.2),
                                                .clear, .clear
                                            ],
                                        startPoint: .leading,
                                        endPoint: .trailing),
                        style: StrokeStyle(lineWidth: 2,
                                           lineCap: .round,
                                           lineJoin: .round,
                                           miterLimit: 1,
                                           dash: [3],
                                           dashPhase: 1))
                .offset(x: offset)
                .overlay {
                    // MARK: SeekerView
                    HStack(spacing: 3) {
                        Image(systemName: "arrowtriangle.left.fill")
                            .font(.caption)
                        Image(systemName: "arrowtriangle.right.fill")
                            .font(.caption)
                    }
                    .foregroundColor(.black)
                    .padding(.horizontal, 7)
                    .padding(.vertical, 10)
                    .background {
                        RoundedRectangle(cornerRadius: 10,
                                         style: .continuous)
                            .fill(.white)
                    }
                    .offset(y: -12)
                    .offset(x: offset)
                    .gesture(
                        DragGesture()
                            .updating($offset,
                                      body: { value, out, _ in
                                out = value.location.x - 20
                            })
                    )
                }
        }
        .frame(height: 20)
        .onChange(of: offset,
                  perform: { newValue in
            rotateObject(animate: offset == .zero)
        })
        .animation(.easeInOut(duration: 0.4),
                   value: offset == .zero)
    }
    
    // MARK: 3Dobject Rotation
    func rotateObject(animate: Bool = false) {
        if animate {
            SCNTransaction.begin()
            SCNTransaction.animationDuration = 0.4
        }
        if viewModel.isVerticleLook {
            // The Rotation is more or like same as 3D Rotation is SwiftUI
            let newAngle = Float((offset * .pi) / 180)
            viewModel.scene?.rootNode.childNode(withName: "Root", recursively: true)?.eulerAngles.y = newAngle
        } else {
            let newAngle = Float((offset * .pi) / 180)
            viewModel.scene?.rootNode.childNode(withName: "Root", recursively: true)?.eulerAngles.x = newAngle
        }
       
        
        if animate  {
            SCNTransaction.commit()
            
        }
    }
}

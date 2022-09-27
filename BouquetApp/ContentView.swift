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

struct ContentView : View {
    @State private var isShowFullModal: Bool = false
    @EnvironmentObject var arSceneManager: ARSceneManager
    var body: some View {
        ZStack(alignment: .bottom) {
            MainARViewContainer()
            if !arSceneManager.isSelectedModel {
                HStack {
                    Spacer()
                    Button(action: {
                        self.isShowFullModal = true
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
        .fullScreenCover(isPresented: $isShowFullModal) {
            FlowerList(isShowFullModal: $isShowFullModal)
        }
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        // Load the "Box" scene from the "Experience" Reality File
        let boxAnchor = try! Experience.loadBox()
        
        // Add the box anchor to the scene
        arView.scene.anchors.append(boxAnchor)
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

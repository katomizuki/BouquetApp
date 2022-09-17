//
//  ContentView.swift
//  BouquetApp
//
//  Created by ミズキ on 2022/09/17.
//
// 花束を作る画面。
// 送る画面
// メッセも同時に送れるのであればする。
// 花を見れる画面
// Multiper Helper

import SwiftUI
import RealityKit

struct ContentView : View {
    var body: some View {
        Home()
            .edgesIgnoringSafeArea(.all)
            .statusBarHidden()
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

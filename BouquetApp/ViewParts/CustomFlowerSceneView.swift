//
//  CustomFlowerSceneView.swift
//  BouquetApp
//
//  Created by ミズキ on 2022/09/19.
//

import SwiftUI
import SceneKit

struct CustomFlowerSceneView: UIViewRepresentable {
    @Binding var scene: SCNScene?
    typealias UIViewType = SCNView
    
    func makeUIView(context: Context) -> SCNView {
        let view = SCNView()
        view.allowsCameraControl = false
        view.autoenablesDefaultLighting = true
        view.antialiasingMode = .multisampling2X
        view.scene = scene
        view.backgroundColor = .clear
        return view
    }
    
    func updateUIView(_ uiView: SCNView, context: Context) {
        
    }
    
}

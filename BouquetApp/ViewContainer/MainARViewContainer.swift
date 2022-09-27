//
//  MainARViewContainer.swift
//  BouquetApp
//
//  Created by ミズキ on 2022/09/18.
//

import SwiftUI
import RealityKit
import ARKit

struct MainARViewContainer: UIViewRepresentable {
    @EnvironmentObject var arSceneManager: ARSceneManager
    
    typealias UIViewType = MainARView
    
    func makeUIView(context: Context) -> MainARView {
        let arView = MainARView(frame: .zero)
        arSceneManager.sceneObserver = arView.scene.subscribe(to: SceneEvents.Update.self, { _ in
            arView.setupFocusEntity(isSelectedModel: arSceneManager.isSelectedModel)
            self.setupModelEntity(arView)
            self.changeSelectedModelStatus(arView)
        })
        return arView
    }
    
    func updateUIView(_ uiView: MainARView, context: Context) {
        
    }
    
    func setupModelEntity(_ arView: MainARView) {
        if arView.selectedModelEntity == nil,
            let flower = arSceneManager.selectedFlower {
            arView.setupModelEntity(modelEntity: flower)
            arSceneManager.selectedFlower = nil
        }
    }
    
    func changeSelectedModelStatus(_ arView: MainARView) {
        if arView.selectedModelEntity == nil {
            arSceneManager.isSelectedModel = false
        }
    }
}


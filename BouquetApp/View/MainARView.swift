//
//  MainARView.swift
//  BouquetApp
//
//  Created by ミズキ on 2022/09/18.
//

import SwiftUI
import ARKit
import RealityKit

class MainARView: ARView {
   
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
        setupConfiguration()
        setupUI()
    }
    
    private func setupConfiguration() {
        let config = ARWorldTrackingConfiguration()
        session.run(config)
    }
    
    private func setupUI() {
        
    }
    
    @MainActor required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//
//  MainARViewContainer.swift
//  BouquetApp
//
//  Created by ミズキ on 2022/09/18.
//

import SwiftUI

struct MainARViewContainer: UIViewRepresentable {
    typealias UIViewType = MainARView
    
    func makeUIView(context: Context) -> MainARView {
        let arView = MainARView(frame: .zero)
        return arView
    }
    
    func updateUIView(_ uiView: MainARView, context: Context) {
        
    }
}


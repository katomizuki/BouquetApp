//
//  FlowerDetailViewModel.swift
//  BouquetApp
//
//  Created by ミズキ on 2022/09/19.
//

import SceneKit
import SwiftUI

final class FlowerDetailViewModel: ObservableObject {
    
    @Published var scene: SCNScene?
    @Published var isVerticleLook: Bool = true
    let flower: Flower
    init (flower: Flower) {
        scene = .init(named: flower.name + ".scn")
        self.flower = flower
    }
}

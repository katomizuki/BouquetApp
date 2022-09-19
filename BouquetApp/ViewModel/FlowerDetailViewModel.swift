//
//  FlowerDetailViewModel.swift
//  BouquetApp
//
//  Created by ミズキ on 2022/09/19.
//

import SceneKit
import SwiftUI

final class FlowerDetailViewModel: ObservableObject {
    
    @Published var scene: SCNScene? = .init(named: "satsuki.scn")
    @Published var isVerticleLook: Bool = true
    
}

//
//  ARSceneViewModel.swift
//  BouquetApp
//
//  Created by ミズキ on 2022/10/01.
//

import Foundation

final class ARSceneViewModel: ObservableObject {
    
    @Published var isShowFullModal: Bool = false
    @Published var isTappedSendButton: Bool = false
}

//
//  ARSceneManager.swift
//  BouquetApp
//
//  Created by ミズキ on 2022/09/25.
//

import Combine
import RealityKit

final class ARSceneManager: ObservableObject {

    @Published var isSelectedModel: Bool = false
    var selectedFlower: ModelEntity?
    var sceneObserver: Cancellable?
    var cancellable: AnyCancellable?
    
    func setSelectedModelEntity(flower: Flower,
                                completion: @escaping(_ modelEntity: ModelEntity) -> Void) {
        let fileName = flower.name + ".usdz"
        cancellable = ModelEntity.loadModelAsync(named: fileName)
            .sink { loadCompletion in
                switch loadCompletion {
                case .failure(_):
                    return
                case .finished: break
                }
            } receiveValue: {  modelEntity in
                completion(modelEntity)
            }
    }
    
    func onTapDecideButton(flower: Flower) {
        isSelectedModel = true
        self.setSelectedModelEntity(flower: flower) { [weak self] modelEntity in
            self?.selectedFlower = modelEntity
            self?.selectedFlower?.scale *= 0.025
        }
    }
}

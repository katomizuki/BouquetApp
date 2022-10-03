//
//  MainARView.swift
//  BouquetApp
//
//  Created by ミズキ on 2022/09/18.
//

import ARKit
import RealityKit
import MultipeerHelper
import MultipeerConnectivity
import FocusEntity
import CoreHaptics

final class MainARView: ARView {
   
    var multipeerHelp: MultipeerHelper!
    var focusEntity: FocusEntity?
    var selectedModelEntity: ModelEntity?
    
    required init(frame frameRect: CGRect) {
            super.init(frame: frameRect)
            setupConfiguration()
            setupMultipeer()
            setupTouchUpEvent()
    }
    
    func setupFocusEntity(isSelectedModel: Bool) {
        if isSelectedModel, self.focusEntity == nil {
            self.focusEntity = FocusEntity(on: self, style: .classic(color: .cyan))
        }
        
        if !isSelectedModel, self.focusEntity != nil {
            self.focusEntity = nil
        }
    }
    
    func setupModelEntity(modelEntity: ModelEntity?) {
        guard let modelEntity = modelEntity else {
            return
        }
        self.selectedModelEntity = modelEntity
    }
    private func setupConfiguration() {
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = .horizontal
        config.isCollaborationEnabled = true
        session.delegate = self
        session.run(config)
    }
    
    private func setupTouchUpEvent() {
        let touchGesture = UITapGestureRecognizer(target: self, action: #selector(onTouchARView))
        addGestureRecognizer(touchGesture)
        isUserInteractionEnabled = true
    }
    
    private func setupMultipeer() {
        multipeerHelp = MultipeerHelper(serviceName: "helper-test",
                                        sessionType: .both,
                                        delegate: self)
        guard let syncService = multipeerHelp.syncService else {
            fatalError()
        }
        
        scene.synchronizationService = syncService
    }
    
    @objc private func onTouchARView(_ sender: UITapGestureRecognizer) {
        let tapPoint = sender.location(in: self)
        guard let rayResults = ray(through: tapPoint) else { return }
        let hitResults = scene.raycast(from: rayResults.origin, to: rayResults.direction)
        if let collisionPoint = hitResults.first {
            // 他のオブジェクトと当たった時
            var position = collisionPoint.position
            position.y += 0.15
            placeFlower(at: position)
        } else {
            let results = raycast(from: tapPoint, allowing: .estimatedPlane, alignment: .any)
            if let hitPoint = results.first {
                let position = simd_make_float3(hitPoint.worldTransform.columns.3)
                placeFlower(at: position)
                print(position)
            }
        }
    }
    
    private func placeFlower(at position: simd_float3) {
        guard let modelEntity = selectedModelEntity else { return }
        modelEntity.generateCollisionShapes(recursive: false)
        installGestures([.rotation,.rotation], for: modelEntity)
        let anchorEntity = AnchorEntity(world: position)
        anchorEntity.addChild(modelEntity)
        scene.anchors.append(anchorEntity)
        selectedModelEntity = nil
    }
    
    
    @MainActor required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func sendARWorld() {
      
        session.getCurrentWorldMap { worldMap, error in
            guard let map = worldMap else { return }
            do {
                let mapData = try NSKeyedArchiver.archivedData(withRootObject: map,
                                                               requiringSecureCoding: true)
                if CHHapticEngine.capabilitiesForHardware().supportsHaptics {
                    self.eventHaptics()
                } else {
                    print("サポートされてない")
                }
                self.multipeerHelp.sendToAllPeers(mapData)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

extension MainARView: ARSessionDelegate {
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        
    }
    
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        print("Anchorが追加された")
    }
}

extension MainARView: MultipeerHelperDelegate {
    func shouldSendJoinRequest(peerHelper: MultipeerHelper, _ peer: MCPeerID, with discoveryInfo: [String : String]?) -> Bool {
        if MainARView.checkPeerToken(with: discoveryInfo) {
            return true
        }
        return false
    }
    
    func receivedData(peerHelper: MultipeerHelper, _ data: Data, _ peer: MCPeerID) {
        
        eventHaptics()
        
        if let worldMap = try? NSKeyedUnarchiver.unarchivedObject(ofClass: ARWorldMap.self, from: data) {
            let config = ARWorldTrackingConfiguration()
            config.initialWorldMap = worldMap
            session.run(config, options: [.resetTracking, .removeExistingAnchors])
        }
    }
    
    func peerJoined(peerHelper: MultipeerHelper, _ peer: MCPeerID) {
        print("new peer has joined: \(peer.displayName)")
    }
}

extension MainARView {
    func eventHaptics() {
        // CoreHapticsをする
        guard let  hapticEngine = try? CHHapticEngine() else { return }
        do {
            try hapticEngine.start()
        } catch {
            print(error.localizedDescription)
        }
        
        let pattern = self.makeHapticPattern()
        guard let player = try? hapticEngine.makePlayer(with: pattern) else { return }
        
        do {
            try player.start(atTime: CHHapticTimeImmediate)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func makeHapticPattern() -> CHHapticPattern {
        let audioEvent = CHHapticEvent(eventType: .audioContinuous,
                                       parameters: [
            CHHapticEventParameter(parameterID: .audioPitch,
                                   value: -0.15),
            CHHapticEventParameter(parameterID: .audioVolume,
                                   value: 0.5),
            CHHapticEventParameter(parameterID: .decayTime,
                                   value: 0),
            CHHapticEventParameter(parameterID: .sustained,
                                   value: 0)
        ],
                                       relativeTime: 0)
        let hapticEvent = CHHapticEvent(eventType: .hapticTransient,
                                       parameters: [
                                        CHHapticEventParameter(parameterID: .hapticIntensity,
                                                               value: 1),
                                        CHHapticEventParameter(parameterID: .hapticIntensity,
                                                               value: 1)
                                       ],
                                       relativeTime: 0)
        let pattern = try! CHHapticPattern(events: [audioEvent, hapticEvent], parameters: [])
        
        return pattern
    }
}

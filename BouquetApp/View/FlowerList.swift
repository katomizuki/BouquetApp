//
//  FlowerList.swift
//  BouquetApp
//
//  Created by ミズキ on 2022/09/22.
//

import SwiftUI

struct FlowerList: View {
    @State private var path: [Flower] = []
    @Binding var isShowFullModal: Bool
    private let flowers: Flowers = Flowers()
    
    var body: some View {
        NavigationStack(path: $path) {
            List(flowers.list) { flower in
                        NavigationLink(value: flower) {
                            Text(flower.name)
                                .fontWeight(.semibold)
                        }
            }
            .navigationTitle("Flowers")
            .navigationDestination(for: Flower.self) { flower in
                FlowerDetail(viewModel: FlowerDetailViewModel(flower: flower),
                             isShowFullModal: $isShowFullModal)
            }
        }
    }
}

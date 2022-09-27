//
//  PropertiesFlowerView.swift
//  BouquetApp
//
//  Created by ミズキ on 2022/09/19.
//

import SwiftUI

struct PropertiesFlowerView: View {
    @ObservedObject var viewModel: FlowerDetailViewModel
    @EnvironmentObject var arSceneManager: ARSceneManager
    @Binding var isShowFullModal: Bool
    
    var body: some View {
        VStack {
            VStack(alignment: .leading,
                   spacing: 12) {
                Text("flower")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                
                Text("aaaaaaaaaaa")
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                    
                Label {
                    Text("sss")
                        .fontWeight(.semibold)
                } icon: {
                    Image(systemName: "star.fill")
                }
                .foregroundColor(Color("Gold"))

            }
            .padding(.top, 30)
            .frame(maxWidth: .infinity,
                   alignment: .leading)
            
            
            HStack(alignment: .top) {
                Button {
                    arSceneManager.onTapDecideButton(flower: viewModel.flower)
                    isShowFullModal.toggle()
                } label: {
                    VStack(spacing: 12) {
                        Image(systemName: "plus.square.dashed")
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 45,
                                   height: 45)
                        
                        Text("Decide!!")
                            .fontWeight(.semibold)
                            .padding(.top, 20)
                    }
                    .foregroundColor(.black)
                    .padding(18)
                    .background {
                        RoundedRectangle(cornerRadius: 20,
                                         style: .continuous)
                            .fill(.white)
                    }
                }
                VStack(alignment: .leading,
                       spacing: 10) {
                    Text("説明が入るよ/n説明が入るよ/n説明が入るよ/n説明が入るよ/n説明が入るよ/n説明が入るよ/n説明が入るよ")
                        .font(.callout)
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)

                }
                .frame(maxWidth: .infinity,
                       alignment: .leading)
            }
            .padding(.top, 30)
        }
    }
}


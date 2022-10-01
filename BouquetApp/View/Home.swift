//
//  Home.swift
//  BouquetApp
//
//  Created by ミズキ on 2022/09/17.
//

import SwiftUI

struct Home: View {
    @State var signUp = false
    @State var user = ""
    @State var pass = ""
    @State var rePass = ""
    
    
    var body: some View {
        // 一番奥のZView
        NavigationView {
            ZStack(alignment: Alignment(horizontal: .center,
                                        vertical: .top)) {
                // 2階層目のZView
                ZStack {
                    /// 一番手前のZView
                    ZStack(alignment: Alignment(horizontal: .trailing,
                                                vertical: .bottom)) {
                        Color("Color")
                            .clipShape(CSharpe())
                        
                        // Path
                        Path { path in
                            // adding 40 for center
                            path.addArc(center: CGPoint(x: UIScreen.main.bounds.width - 120,
                                                        y: UIScreen.main.bounds.height - 50),
                                        radius: 40,
                                        startAngle: .zero,
                                        endAngle: .init(degrees: 180),
                                        clockwise: true)
                        }
                        .fill(Color.white)
                        
                        // adding 40 for center
                        
                        
                        Button(action: {
                            withAnimation(.easeIn) {
                                print("Loginへ")
                                self.signUp = false
                            }
                        }) {
                            Image(systemName: signUp ? "xmark" : "person.fill")
                                .font(.system(size: signUp ? 25 : 26,
                                              weight: .bold))
                                .foregroundColor(Color("Color"))
                        }
                        .offset(x: -110, y: -50)
                        .disabled(signUp ? false : true)
                        
                        Button(action: {
                            withAnimation(.easeOut) {
                                print("押せてる")
                                self.signUp = true
                            }
                        }) {
                            Image(systemName: signUp ? "person.badge.plus.fill" : "xmark")
                                .font(.system(size: signUp ? 26 : 25,
                                              weight: .bold))
                                .foregroundColor(.white)
                        }
                        .offset(x: -30, y: -40)
                        .disabled(signUp ? true : false)
                    }
                    
                    // ログインView TopLayer  signup false => 0 signup true => 高さを小さくする
                    VStack(alignment: .leading,
                           spacing: 25) {
                        
                        Text("Login")
                            .font(.system(size: 35,
                                          weight: .bold))
                            .foregroundColor(.white)
                        
                        Text("UserName")
                            .foregroundColor(.white)
                            .padding(.top, 10)
            
                        VStack {
                            TextField("Username",
                                      text: $user)
                            Divider()
                                .background(Color.white.opacity(0.5))
                        }
                        
                        Text("Password")
                            .foregroundColor(.white)
                            .padding(.top, 10)
                        
                        VStack {
                            SecureField("Password",
                                        text: $pass)
                            Divider()
                                .background(Color.white.opacity(0.5))
                        }
                        
                        HStack {
                            Spacer()
                            // Login Button
                            NavigationLink {
                                ARSceneView()
                            } label: {
                                Text("Login")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("Color"))
                                    .padding(.vertical)
                                    .padding(.horizontal, 45)
                                    .background(.white)
                                    .clipShape(Capsule())
                            }
                            Spacer()
                        }
                        .padding(.top)
                        Spacer(minLength: 0)
                    }
                     .padding(.top, (UIApplication.shared.windows.first?.safeAreaInsets.top)! + 25)
                     .padding()
                    
                }
                .offset(y: signUp ? -UIScreen.main.bounds.height + (UIScreen.main.bounds.height < 750 ? 100 : 130) : 0)
                .zIndex(1)
                
                // Sing up View
                VStack(alignment: .leading,
                       spacing: 25) {
                    
                    Text("Sign Up")
                        .font(.system(size: 35, weight: .bold))
                        .foregroundColor(Color("Color"))
                    
                    Text("UserName")
                        .foregroundColor(Color("Color"))
                        .padding(.top, 10)
        
                    VStack {
                        TextField("Username", text: $user)
                        Divider()
                            .background(Color.white.opacity(0.5))
                    }
                    
                    Text("Password")
                        .foregroundColor(Color("Color"))
                        .padding(.top, 10)
                    
                    VStack {
                        SecureField("Password", text: $pass)
                        Divider()
                            .background(Color("Color").opacity(0.5))
                    }
                    // use separater
                    Text("Re-Enter")
                        .foregroundColor(Color("Color"))
                        .padding(.top, 10)
                    
                    VStack {
                        SecureField("Re-Enter", text: $rePass)
                        
                        Divider()
                            .background(Color.white.opacity(0.5))
                    }
                    HStack {
                        Spacer()
                        NavigationLink {
                            ARSceneView()
                        } label: {
                            Text("Sign up")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.vertical)
                                .padding(.horizontal, 45)
                                .background(Color("Color"))
                                .clipShape(Capsule())
                        }
                        Spacer()
                    }
                    Spacer(minLength: 0)
                }
                 .padding(.top, (UIApplication.shared.windows.first?.safeAreaInsets.top)! + 50)
                 .padding()
            }
            .background(Color.white.edgesIgnoringSafeArea(.all))
            .preferredColorScheme(signUp ? .light : .dark)
            // changin user interface
        }.edgesIgnoringSafeArea(.all)
            .statusBarHidden()
        
    }
}


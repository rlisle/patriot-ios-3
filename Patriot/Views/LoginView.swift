//
//  LoginView.swift
//  Patriot
//
//  Created by Ron Lisle on 5/27/21.
//

import SwiftUI

enum LoginFocusable: Hashable {
    case username
    case password
}

struct LoginView: View {
    
    @EnvironmentObject var devices: PatriotModel
    
    @State private var userName = ""
    @State private var password = ""
    
    @State private var hideSpinner = true
    
    @FocusState private var loginInFocus: LoginFocusable?
    
    var body: some View {
        ZStack {
            ProgressView().isHidden(hideSpinner)
            
            GeometryReader { metrics in
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        VStack(alignment: .center, spacing: 20, content: {
                            Text("Login to your Particle.io account")
                                .padding(.horizontal, -4)
                                .padding(.vertical, 12)
                            TextField("User name", text: $userName)
                                .autocapitalization(.none)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                //.background(Color.gray)
                            SecureField("Password", text: $password)
                                //.autocapitalization(.none)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                //.background(Color.gray)
                            HStack {
                                Button(action: {
                                    handleLogin()
                                }, label: {
                                    Text("Login")
                                        .padding(.horizontal, 24)
                                        .padding(.vertical, 8)
                                        .background(Color.blue)
                                        .foregroundColor(Color.white)
                                        .cornerRadius(20)
                                })
                                .disabled(userName == "" || password == "")
                                
                                Button(action: {
                                    handleMQTTOnly()
                                }) {
                                    Text("MQTT-Only")
                                        .padding(.horizontal, 24)
                                        .padding(.vertical, 8)
                                        .background(Color.blue)
                                        .foregroundColor(Color.white)
                                        .cornerRadius(20)
                                }
                            }
                            .padding(.bottom, 10)

                        })
                        .padding(20)
                        .frame(width: metrics.size.width * 0.75, alignment: .center)
                        .background(Color.indigo) //TODO: dark gray
                        .cornerRadius(30)
                        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        Spacer()
                    }
                    Spacer()
                }
            }
        }
    }
    
    func fetchDevices() {
        //TODO:
    }
    
    func handleMQTTOnly() {
//        devices.setHardcodedDevices()
        devices.showingLogin = false
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(PatriotModel())

    }
}

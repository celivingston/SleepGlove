//
//  ContentView.swift
//  SleepGlove
//
//  Created by Catherine Livingston on 2/22/22.
//

import SwiftUI

struct ContentView: View {
    @State private var connecting = false
    @State private var connectingLabel = "Connect to my Sleep Glove"
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Hello, Sleep Glove user!")
                    .font(.system(size: 30, weight: .bold, design: .default))
                    .padding([.top], 30)
                Text("Are you ready to connect your glove?")
                    .font(.system(size: 30, design: .default))
                Spacer()
                NavigationLink(destination: BluetoothDiscoveryView()) {
                    Text(connectingLabel)
                        .fontWeight(.bold)
                        .padding(20)
                        .foregroundColor(.white)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(30)
                        .shadow(radius: 5.0)
                }
                
                Text("Be sure that your glove is turned on before attempting to connect.")
                    .font(.caption)
                    .padding(15)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                
                    .navigationBarHidden(true)
            }
        }
    
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
.previewInterfaceOrientation(.portrait)
    }
}

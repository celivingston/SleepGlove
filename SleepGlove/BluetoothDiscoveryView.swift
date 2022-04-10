//
//  BluetoothDiscoveryView.swift
//  SleepGlove
//
//  Created by Catherine Livingston on 2/22/22.
//

import SwiftUI
import CoreBluetooth

struct BluetoothDiscoveryView: View {
    @State private var connected = false
    @State private var shouldAnimate = false
    @State private var willMoveToNextScreen = false
    @ObservedObject var bleManager = BLEManager()
    @State var scanningText = "Start Scanning"
    
    var body: some View {
        VStack {
            if bleManager.isConnected == false {
                Button(action: {
                    self.bleManager.startScanning()
                    scanningText = "Scanning..."
                }) {
                    Text(scanningText)
                        .fontWeight(.bold)
                        .padding(20)
                        .foregroundColor(.white)
                        .shadow(radius: 5.0)
                }
                    .padding()
                    .disabled(bleManager.isScanning)
                    .buttonStyle(MyButtonStyle())
                    
            }
            
            
            if bleManager.isConnected {
                Text("Glove is connnected! Now let's callibrate.")
                    .fontWeight(.bold)
                    .padding(20)
                ZStack {
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 12, height: 12)
                        .modifier(ParticlesModifier())
                        .offset(x: -100, y : -50)
                            
                    Circle()
                        .fill(Color.red)
                        .frame(width: 12, height: 12)
                        .modifier(ParticlesModifier())
                        .offset(x: 60, y : 70)
                }
                Button(action: {
                    self.willMoveToNextScreen = true
                }) {
                    Text("Start Callibration")
                        .fontWeight(.bold)
                        .padding(20)
                        .foregroundColor(.blue)
                        //.shadow(radius: 5.0)
                }
            }
        }.navigate(to: CalibrationStart(bleManager: bleManager), when: $willMoveToNextScreen).padding()
        
    }
}

struct DarkBlueShadowProgressViewStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        var shouldAnimate = false
        configuration.label
            .foregroundColor(.blue)
        HStack(alignment: .center, spacing: shouldAnimate ? 15 : 5) {
            Capsule(style: .continuous)
                .fill(Color.blue)
                .frame(width: 10, height: 50)
            Capsule(style: .continuous)
                .fill(Color.blue)
                .frame(width: 10, height: 30)
            Capsule(style: .continuous)
                .fill(Color.blue)
                .frame(width: 10, height: 50)
            Capsule(style: .continuous)
                .fill(Color.blue)
                .frame(width: 10, height: 30)
            Capsule(style: .continuous)
                .fill(Color.blue)
                .frame(width: 10, height: 50)
        }
        .frame(width: shouldAnimate ? 150 : 100)
        .animation(
            .easeInOut(duration: 1)
                .repeatForever(autoreverses: true))
        .onAppear {
            shouldAnimate = true
            
        }
    }
}

struct ParticlesModifier: ViewModifier {
    @State var time = 0.0
    @State var scale = 0.1
    let duration = 5.0
    
    func body(content: Content) -> some View {
        ZStack {
            ForEach(0..<80, id: \.self) { index in
                content
                    .hueRotation(Angle(degrees: time * 80))
                    .scaleEffect(scale)
                    .modifier(FireworkParticlesGeometryEffect(time: time))
                    .opacity(((duration-time) / duration))
            }
        }
        .onAppear {
            withAnimation (.easeOut(duration: duration)) {
                self.time = duration
                self.scale = 1.0
            }
        }
    }
}


struct FireworkParticlesGeometryEffect : GeometryEffect {
    var time : Double
    var speed = Double.random(in: 20 ... 200)
    var direction = Double.random(in: -Double.pi ...  Double.pi)
    
    var animatableData: Double {
        get { time }
        set { time = newValue }
    }
    func effectValue(size: CGSize) -> ProjectionTransform {
        let xTranslation = speed * cos(direction) * time
        let yTranslation = speed * sin(direction) * time
        let affineTranslation =  CGAffineTransform(translationX: xTranslation, y: yTranslation)
        return ProjectionTransform(affineTranslation)
    }
}

struct MyButtonStyle: ButtonStyle {
  func makeBody(configuration: Self.Configuration) -> some View {
    MyButtonStyleView(configuration: configuration)
  }
}

private extension MyButtonStyle {
  struct MyButtonStyleView: View {
    // tracks if the button is enabled or not
    @Environment(\.isEnabled) var isEnabled
    // tracks the pressed state
    let configuration: MyButtonStyle.Configuration

    var body: some View {
      return configuration.label
        // change the text color based on if it's disabled
        .background(RoundedRectangle(cornerRadius: 30)
          // change the background color based on if it's disabled
            //.fill(isEnabled ? Color.blue : Color.gray)
                        .fill(isEnabled ? LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), startPoint: .leading, endPoint: .trailing) : LinearGradient(gradient: Gradient(colors: [Color.gray, Color.gray]), startPoint: .leading, endPoint: .trailing))
        )
        // make the button a bit more translucent when pressed
        .opacity(configuration.isPressed ? 0.8 : 1.0)
        // make the button a bit smaller when pressed
        .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
    }
  }
}

struct BluetoothDiscoveryView_Previews: PreviewProvider {
    static var previews: some View {
        BluetoothDiscoveryView()
    }
}

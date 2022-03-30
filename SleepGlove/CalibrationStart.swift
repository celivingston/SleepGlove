//
//  CalibrationStart.swift
//  SleepGlove
//
//  Created by Catherine Livingston on 3/2/22.
//

import SwiftUI

struct CalibrationStart: View {
    var bleManager: BLEManager
    @State private var willMoveToNextScreen = false
    
    var body: some View {
        VStack {
            Text("Glove Setup:")
                .font(.system(size: 30, weight: .bold))
                .padding([.top], 30)
            Text("Tighten the wristband around your wrist with the adjustable band.")
                .padding()
                .font(.system(size: 20, weight: .regular))
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("Have the holding cylinder ready and follow the prompts on each screen")
                .padding()
                .font(.system(size: 20, weight: .regular))
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            Button(action: {
                bleManager.sendText(text: "startSetup")
                self.willMoveToNextScreen = true
            }) {
                Text("Start Setup")
                    .fontWeight(.semibold)
                    .padding(20)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .shadow(radius: 5.0)
                    .cornerRadius(30)
            }.padding()
        }.navigate(to: StepOnePrompt(), when: $willMoveToNextScreen)
        
    }
}

struct CalibrationStart_Previews: PreviewProvider {
    static var previews: some View {
        CalibrationStart(bleManager: BLEManager())
    }
}

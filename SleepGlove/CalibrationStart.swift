//
//  CalibrationStart.swift
//  SleepGlove
//
//  Created by Catherine Livingston on 3/2/22.
//

import SwiftUI

struct CalibrationStart: View {
    var bleManager: BLEManager
    
    var body: some View {
        VStack {
            Text("Glove Setup:")
                .font(.system(size: 30, weight: .bold))
                .padding([.top], 30)
            Text("Hold the cylinder with medium force. When you're ready, press to start callibration below.")
                .padding()
                .font(.system(size: 20, weight: .regular))
            Spacer()
            Button(action: {
                bleManager.sendText(text: "startCalibration")
            }) {
                Text("Start Calibration")
                    .fontWeight(.semibold)
                    .padding(20)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .shadow(radius: 5.0)
                    .cornerRadius(30)
            }.padding()
        }
        
    }
}

struct CalibrationStart_Previews: PreviewProvider {
    static var previews: some View {
        CalibrationStart(bleManager: BLEManager())
    }
}

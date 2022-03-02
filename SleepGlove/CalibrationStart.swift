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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct CalibrationStart_Previews: PreviewProvider {
    static var previews: some View {
        CalibrationStart(bleManager: BLEManager())
    }
}

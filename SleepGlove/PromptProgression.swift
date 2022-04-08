//
//  PromptProgression.swift
//  SleepGlove
//
//  Created by Catherine Livingston on 4/8/22.
//

import SwiftUI

struct PromptProgression: View {
    var promptNumber : Int
    
    var body: some View {
        HStack {
            Text("1")
            Text("2")
            Text("3")
        }
    }
}

struct PromptProgression_Previews: PreviewProvider {
    static var previews: some View {
        PromptProgression(promptNumber: 3)
    }
}

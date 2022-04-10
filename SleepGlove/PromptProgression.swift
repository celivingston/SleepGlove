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
        VStack {
            Divider()
            HStack {
                Circle()
                    .fill(promptNumber == 1 ? Color.purple : Color.blue)
                    .frame(width: 25, height: 25)
                Spacer()
                Circle()
                    .fill(promptNumber == 2 ? Color.purple : Color.blue)
                    .frame(width: 25, height: 25)
                Spacer()
                Circle()
                    .fill(promptNumber == 3 ? Color.purple : Color.blue)
                    .frame(width: 25, height: 25)
                Spacer()
                Circle()
                    .fill(promptNumber == 4 ? Color.purple : Color.blue)
                    .frame(width: 25, height: 25)
            }
        }.padding()
    }
}

struct PromptProgression_Previews: PreviewProvider {
    static var previews: some View {
        PromptProgression(promptNumber: 3)
    }
}

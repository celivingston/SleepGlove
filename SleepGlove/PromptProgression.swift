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
                ZStack {
                    Circle()
                        .fill(promptNumber == 1 ? Color.purple : Color.blue)
                        .frame(width: 25, height: 25)
                    Text("1")
                }
                
                Spacer()
                ZStack {
                    Circle()
                        .fill(promptNumber == 2 ? Color.purple : Color.blue)
                        .frame(width: 25, height: 25)
                    Text("2")
                }
                
                Spacer()
                ZStack {
                    Circle()
                        .fill(promptNumber == 3 ? Color.purple : Color.blue)
                        .frame(width: 25, height: 25)
                    Text("3")
                }
                
                Spacer()
                ZStack {
                    Circle()
                        .fill(promptNumber == 4 ? Color.purple : Color.blue)
                        .frame(width: 25, height: 25)
                    Text("4")
                }
                
            }
        }.padding()
    }
}

struct PromptProgression_Previews: PreviewProvider {
    static var previews: some View {
        PromptProgression(promptNumber: 3)
    }
}

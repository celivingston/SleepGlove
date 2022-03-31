//
//  StepOnePrompt.swift
//  SleepGlove
//
//  Created by Catherine Livingston on 3/29/22.
//

import SwiftUI

struct StepOnePrompt: View {
    private enum Field: Int, CaseIterable {
        case dreamFocus
    }
    
    let placeholder : String = "Start typing here..."
    @State private var dreamFocus: String = "Start typing here..."
    @State private var willMoveToNextScreen = false
    @FocusState private var focusedField: Field?
    
    init() {
            UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        VStack {
            Text("What do you want to dream about?")
                .font(.system(size: 30, weight: .bold))
                .padding([.top], 40)
                .padding([.leading, .trailing], 15)
                .padding([.bottom], 3)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("Write a couple phrases about what you would like to dream about.")
                .padding([.leading, .trailing], 15)
                .frame(maxWidth: .infinity, alignment: .leading)
            TextEditor(text: $dreamFocus)
                .padding()
                .background(Color.gray.opacity(0.25))
                .font(Font.custom("AvenirNext-Regular", size: 15, relativeTo: .body))
                .frame(width: 300, height: 200, alignment: .center)
                .cornerRadius(15)
                .onTapGesture {
                    if self.dreamFocus == placeholder {
                        self.dreamFocus = ""
                    }
                }
                .focused($focusedField, equals: .dreamFocus)
                .toolbar {
                    ToolbarItem(placement: .keyboard) {
                        Button("Done") {
                            focusedField = nil
                        }
                    }
                }
            Spacer()
            Button(action: {
                self.willMoveToNextScreen = true
            }) {
                Text("Next")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    
            }   .padding()
                .frame(width: 200)
                .background(Color.blue)
                .shadow(radius: 5.0)
                .cornerRadius(30)
            
        }.navigate(to: StepTwoPrompt(), when: $willMoveToNextScreen)
    }
    
    private func endEditing() {
        UIApplication.shared.endEditing()
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct StepOnePrompt_Previews: PreviewProvider {
    static var previews: some View {
        StepOnePrompt()
    }
}

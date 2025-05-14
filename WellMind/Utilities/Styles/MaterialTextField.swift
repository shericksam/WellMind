//
//  MaterialTextField.swift
//  WellMind
//
//  Created by Erick Samuel Guerrero Arreola on 13/05/25.
//

import SwiftUI

struct MaterialTextField: View {
    @State private var text: String = ""
    @State private var isFocused: Bool = false
    var placeholder: String
    var primaryColor: Color = .teal
    var icon: Image = Image(systemName: "person")
    var body: some View {
        HStack(spacing: 0) {
            icon
                .resizable()
                .symbolRenderingMode(.hierarchical)
                .frame(width: 20, height: 20)
                .foregroundColor(isFocused || !text.isEmpty ? primaryColor : .gray)
                .padding()
            ZStack {
                HStack(alignment: .center) {
                    Text(placeholder)
                        .foregroundColor(isFocused || !text.isEmpty ? primaryColor : .gray)
                        .scaleEffect(isFocused || !text.isEmpty ? 0.8 : 1.0, anchor: .leading)
                        .offset(y: isFocused || !text.isEmpty ? -25 : -10)
                        .animation(.easeInOut(duration: 0.2), value: isFocused || !text.isEmpty)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                
                TextField("", text: $text, onEditingChanged: { editing in
                    withAnimation {
                        isFocused = editing
                    }
                })
                .textFieldStyle(PlainTextFieldStyle())
                
            }
            .padding(.top, 10)
            .animation(.easeInOut(duration: 0.2), value: isFocused)
        }
        .overlay(
            Rectangle()
                .frame(height: 1)
                .foregroundColor(isFocused ? primaryColor : .gray),
            alignment: .bottom
        )
    }
}

struct MaterialTextFieldView: View {
    var body: some View {
        VStack {
            MaterialTextField(placeholder: "Enter your text")
                .padding()
            
            Spacer()
        }
        .padding()
    }
}

struct MaterialTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        MaterialTextFieldView()
    }
}

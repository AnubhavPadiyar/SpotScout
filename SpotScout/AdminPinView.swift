//
//  AdminPinView.swift
//  SpotScout
//
//  Created by Anubhav on 26/01/26.
//

import SwiftUI

struct AdminPinView: View {

    let correctPin = "1234"   // 🔐 Change later if needed

    @State private var enteredPin = ""
    @State private var showError = false

    let onSuccess: () -> Void
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(spacing: 24) {

            Text("Admin Access")
                .font(.title)
                .bold()

            SecureField("Enter 4-digit PIN", text: $enteredPin)
                .keyboardType(.numberPad)
                .textFieldStyle(.roundedBorder)
                .frame(maxWidth: 200)

            if showError {
                Text("Incorrect PIN")
                    .foregroundColor(.red)
            }

            Button("Unlock") {
                if enteredPin == correctPin {
                    dismiss()
                    onSuccess()
                } else {
                    showError = true
                    enteredPin = ""
                }
            }
            .buttonStyle(.borderedProminent)

            Button("Cancel") {
                dismiss()
            }
            .foregroundColor(.gray)

            Spacer()
        }
        .padding()
    }
}


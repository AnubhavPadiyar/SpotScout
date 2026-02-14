//
//  AdminUpdateView.swift
//  SpotScout
//
//  Created by Anubhav on 26/01/26.
//

import SwiftUI

struct AdminUpdateView: View {

    @Binding var library: Library
    @Environment(\.dismiss) var dismiss

    @State private var seatText = ""

    var body: some View {
        VStack(spacing: 24) {

            Text("Admin Panel")
                .font(.title)
                .bold()

            Text(library.name)
                .font(.headline)

            Text("Set Available Seats")
                .foregroundColor(.gray)

            TextField("Enter seat count", text: $seatText)
                .keyboardType(.numberPad)
                .textFieldStyle(.roundedBorder)
                .onAppear {
                    seatText = "\(library.availableSpots)"
                }

            Button("Update Seats") {
                if let value = Int(seatText) {
                    library.availableSpots = max(0, value)
                }
                dismiss()
            }
            .buttonStyle(.borderedProminent)

            Spacer()
        }
        .padding()
    }
}


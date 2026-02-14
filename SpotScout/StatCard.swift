//
//  StatCard.swift
//  SpotScout
//
//  Created by Anubhav on 25/01/26.
//
import SwiftUI

struct StatCard: View {
    let title: String
    let value: String

    var body: some View {
        VStack(spacing: 8) {
            Text(value)
                .font(.largeTitle)
                .bold()
            Text(title)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.gray.opacity(0.15))
        .cornerRadius(14)
    }
}

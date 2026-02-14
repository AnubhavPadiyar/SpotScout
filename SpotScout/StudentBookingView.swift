import SwiftUI

struct StudentBookingView: View {

    @Binding var library: Library
    @Environment(\.dismiss) private var dismiss

    @State private var hasBooked = false
    @State private var hasLeft = false
    @State private var showConfirmLeave = false

    var body: some View {
        VStack(spacing: 28) {

            // Library name
            Text(library.name)
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)

            // Seat status
            VStack(spacing: 6) {
                Text("Available Seats")
                    .font(.subheadline)
                    .foregroundColor(.gray)

                Text("\(library.availableSpots)")
                    .font(.system(size: 48, weight: .bold))
                    .foregroundColor(seatColor)
            }

            // BOOK BUTTON
            if !hasBooked {
                Button {
                    bookSeat()
                } label: {
                    Text("Book Seat")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            library.availableSpots > 0
                            ? Color.blue
                            : Color.gray.opacity(0.5)
                        )
                        .foregroundColor(.white)
                        .cornerRadius(14)
                }
                .disabled(library.availableSpots == 0)
            }

            // LEAVE BUTTON
            if hasBooked && !hasLeft {
                Button {
                    showConfirmLeave = true
                } label: {
                    Text("I'm Leaving")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(14)
                }
                .alert("Confirm Leaving", isPresented: $showConfirmLeave) {
                    Button("Cancel", role: .cancel) {}
                    Button("Yes, I'm Leaving", role: .destructive) {
                        releaseSeat()
                    }
                } message: {
                    Text("Are you sure you are leaving the library now?")
                }
            }

            Spacer()
        }
        .padding()
    }

    // MARK: - Logic

    private func bookSeat() {
        guard library.availableSpots > 0 else { return }

        library.availableSpots -= 1
        hasBooked = true

        var bookings =
            UserDefaults.standard.stringArray(forKey: "myBookings") ?? []
        bookings.append(library.name)
        UserDefaults.standard.set(bookings, forKey: "myBookings")
    }

    private func releaseSeat() {
        guard hasBooked && !hasLeft else { return }

        library.availableSpots += 1
        hasLeft = true
        dismiss()
    }

    // MARK: - Seat Color

    private var seatColor: Color {
        if library.availableSpots >= 3 {
            return .green
        } else if library.availableSpots > 0 {
            return .orange
        } else {
            return .red
        }
    }
}

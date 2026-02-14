import SwiftUI

struct ContentView: View {

    @State private var libraries: [Library] = []

    var body: some View {
        TabView {

            // 🗺️ Campus Tab
            NavigationStack {
                CampusMapView(libraries: $libraries)
            }
            .tabItem {
                Image(systemName: "map")
                Text("Campus")
            }

            // 📋 My Spots Tab
            NavigationStack {
                List {
                    let bookings =
                        UserDefaults.standard.stringArray(forKey: "myBookings") ?? []

                    if bookings.isEmpty {
                        Text("No bookings yet")
                            .foregroundColor(.gray)
                    } else {
                        ForEach(bookings, id: \.self) { name in
                            Text(name)
                        }
                    }
                }
                .navigationTitle("My Spots")
            }
            .tabItem {
                Image(systemName: "list.bullet")
                Text("My Spots")
            }

            // 📊 Stats Tab
            NavigationStack {
                VStack(spacing: 20) {

                    let totalLibraries = libraries.count
                    let totalAvailable =
                        libraries.reduce(0) { $0 + $1.availableSpots }
                    let totalBookings =
                        (UserDefaults.standard.stringArray(forKey: "myBookings") ?? []).count

                    Text("Campus Stats")
                        .font(.largeTitle)
                        .bold()

                    HStack(spacing: 16) {
                        StatCard(title: "Libraries", value: "\(totalLibraries)")
                        StatCard(title: "Available", value: "\(totalAvailable)")
                    }

                    StatCard(title: "Bookings", value: "\(totalBookings)")

                    Spacer()
                }
                .padding()
                .navigationTitle("Stats")
            }
            .tabItem {
                Image(systemName: "chart.bar")
                Text("Stats")
            }
        }
        .onAppear {
            loadLibraries()
        }
    }

    // MARK: - Data

    private func loadLibraries() {
        if let data = UserDefaults.standard.data(forKey: "savedLibraries"),
           let decoded = try? JSONDecoder().decode([Library].self, from: data) {
            libraries = decoded
        } else {
            libraries = [
                Library(name: "GEHU Central Library", availableSpots: 4),
                Library(name: "GEHU Law Library", availableSpots: 2),
                Library(name: "Santoshanand Library", availableSpots: 3),
                Library(name: "CSIT Block Library", availableSpots: 2),
                Library(name: "Chanakya Block Library", availableSpots: 2)
            ]
        }
    }
}

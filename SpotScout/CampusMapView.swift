import SwiftUI
import MapKit

struct CampusLocation: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct CampusMapView: View {

    @Binding var libraries: [Library]

    @State private var selectedLibrary: Library?
    @State private var showBooking = false
    @State private var showAdmin = false
    @State private var showAdminPin = false


    @State private var cameraPosition: MapCameraPosition =
        .region(
            MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: 30.2700,
                    longitude: 77.9950
                ),
                span: MKCoordinateSpan(
                    latitudeDelta: 0.01,
                    longitudeDelta: 0.01
                )
            )
        )

    let locations: [CampusLocation] = [
        CampusLocation(
            name: "GEHU Central Library",
            coordinate: CLLocationCoordinate2D(
                latitude: 30.2723733,
                longitude: 77.9997382
            )
        ),
        CampusLocation(
            name: "GEHU Law Library",
            coordinate: CLLocationCoordinate2D(
                latitude: 30.2723733,
                longitude: 77.9997382
            )
        ),
        CampusLocation(
            name: "Santoshanad Library",
            coordinate: CLLocationCoordinate2D(
                latitude: 30.2673625,
                longitude: 77.9931595
            )
        ),
        CampusLocation(
            name: "CSIT Block Library",
            coordinate: CLLocationCoordinate2D(
                latitude: 30.2688125,
                longitude: 77.9907376
            )
        ),
        CampusLocation(
            name: "Chanakya Block Library",
            coordinate: CLLocationCoordinate2D(
                latitude: 30.2676875,
                longitude: 77.9937376
            )
        )
    ]

    var body: some View {
        Map(position: $cameraPosition) {
            ForEach(locations) { location in
                Annotation(location.name, coordinate: location.coordinate) {
                    
                    Image(systemName: "mappin.circle.fill")
                        .font(.title)
                        .foregroundColor(.red)

                        // 👨‍🎓 STUDENT TAP
                        .onTapGesture {
                            if let index = libraries.firstIndex(where: { $0.name == location.name }) {
                                selectedLibrary = libraries[index]
                                showBooking = true
                            }
                        }

                        // 👨‍💼 ADMIN LONG PRESS → MENU
                        .contextMenu {
                            Button("Admin: Update Seats") {
                                if let index = libraries.firstIndex(where: { $0.name == location.name }) {
                                    selectedLibrary = libraries[index]
                                    showAdminPin = true
                                }
                            }
                        }
                }

            }
        }
        .navigationTitle("Campus Map")

        // Student booking
        .sheet(isPresented: $showBooking) {
            if let index = libraries.firstIndex(where: { $0.id == selectedLibrary?.id }) {
                StudentBookingView(library: $libraries[index])
            }
        }

        // Admin update
        .sheet(isPresented: $showAdmin) {
            if let index = libraries.firstIndex(where: { $0.id == selectedLibrary?.id }) {
                AdminUpdateView(library: $libraries[index])
            }
        }
        .sheet(isPresented: $showAdminPin) {
            AdminPinView {
                showAdmin = true
            }
        }
    }
}

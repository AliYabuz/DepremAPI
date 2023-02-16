import SwiftUI
import MapKit

struct CityValue: Decodable {
    let city: String
    let value: Double
}

struct DepremAPI: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                    // Uygulama arka planda çalışırken yeniden açıldığında bu kod bloğu çalışır
                    UIApplication.shared.windows.first?.rootViewController = UIHostingController(rootView: ContentView())
                }
        }
    }
}

   
class CityValueFetcher: ObservableObject {
    @Published var cityValues = [CityValue]()
    let version = "VERSION 1.0.0"
    @State private var refreshCount = 0
    init() {
      
        guard let url = URL(string: "http://192.168.1.173/log.json") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode([CityValue].self, from: data)
                DispatchQueue.main.async {
                    self.cityValues = decodedData
                }
            } catch let error {
                print("Error decoding data: \(error.localizedDescription)")
            }
        }.resume()
    }
}
struct AboutView: View {
    let version: String
    let developer: String
    
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: "info.circle")
                .font(.system(size: 80))
                .foregroundColor(.blue)
            Text("DepremAPI")
                .font(.largeTitle)
                .fontWeight(.bold)
            Text(version)
                .font(.title)
                .foregroundColor(.gray)
            Text("Geliştirici: \(developer)")
                .font(.title2)
                .foregroundColor(.gray)
            Spacer()
        }
        .padding()
    }
}
struct IstanbulAnnotation: Identifiable {
    let id = UUID()
    let coordinate = CLLocationCoordinate2D(latitude: 41.0082, longitude: 28.9784)
}
struct ContentView: View {
    @ObservedObject var cityValueFetcher = CityValueFetcher()
    @State private var isRefreshing = false
    @State private var refreshCount = 0
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 41.0082, longitude: 28.9784), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))

    var body: some View {
        NavigationView {
            VStack {
               
                List(cityValueFetcher.cityValues, id: \.city) { cityValue in
                    VStack(alignment: .leading) {
                        Text(cityValue.city)
                            .font(.headline)
                        Text("\(cityValue.value) | Derinlik (null)")
                           
                    }
                    Map(coordinateRegion: $region, annotationItems: [IstanbulAnnotation()]) { annotation in
                             MapMarker(coordinate: annotation.coordinate)
                         }
                    .contextMenu {
                                            Button(action: {
                                                let shareText = "DepremÖlçer'de \(cityValue.city) şehrinde \(cityValue.value) şiddetinde bir deprem meydana geldi. #DepremÖlçer"
                                                let activityVC = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
                                                UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
                                            }) {
                                                Label("Deprem bilgilerini paylaş.", systemImage: "square.and.arrow.up")
                                            }
                                        }
                                    }
                                }
          
            .navigationBarTitle(Text("Deprem Ölçer (beta)"), displayMode: .inline)
            
            .navigationBarItems(trailing:
                                    Button(action: {
                UIApplication.shared.windows.first?.rootViewController = UIHostingController(rootView: ContentView())
                self.isRefreshing = true
            }) {
                HStack {
                    if isRefreshing {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .foregroundColor(.white)
                    }
                    Image(systemName: "arrow.clockwise")
                    
                }
                .frame(maxWidth: .infinity, maxHeight: 40)
                .background(Color.black)
                .foregroundColor(.white)
                .cornerRadius(8)
                .padding()
            }
                .disabled(isRefreshing)
            )
            Text("Son Depremler")
        }
        
    }
}


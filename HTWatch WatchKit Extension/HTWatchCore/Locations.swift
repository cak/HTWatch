import Foundation

public struct HTLocations: Decodable {
    public var locations: [Locations]
    public var updatedAt: String
}

public struct Locations: Decodable {
    public var updatedAt: String
    public var conference: String
    public var id: Int
    public var hotel: String
    public var name: String
}

class LocationsManager: ObservableObject {
    
    @Published var locations = [Locations]()
    
    
    init(event: String) {
        guard let url = URL(string: "https://hackertracker.app/\(event)/locations.json") else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            let decoded = self.decodeHTLocations(data: data)
            switch decoded {
            case let .success(decodedData):
                DispatchQueue.main.async {
                    self.locations = decodedData.locations
                }
            case let .failure(error):
                print(error)
                return
            }
        }.resume()
    }
    
    func decodeHTLocations(data: Data) -> Result<HTLocations, HTError> {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let decoded = try? decoder.decode(HTLocations.self, from: data) else { return .failure(.decodeError) }
        return .success(decoded)
        
    }
}


func lookupLocation(id: Int, location: [Locations]) -> String {
    return location.filter( { $0.id == id }).map({ $0.name }).joined(separator: ", ")
}

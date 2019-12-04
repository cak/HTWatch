import Foundation
import Combine

struct HTConferences: Decodable {
    var updatedAt: String
    var conferences: [ConferenceDetails]
}

struct ConferenceDetails: Decodable, Identifiable {
    var name: String
    var endDate: String
    var code: String
    var id: Int
    var startDate: String
    var eventTypes: Links
    var articles: Links
    var vendors: Links
    var description: String
    var faqs: Links
    var updatedAt: String
    var locations: Links
    var notifications: Links
    var events: Links
    var timezone: String
    var link: String
}

struct Links: Decodable {
    var link: String
    var updatedAt: String
}

class ConferencesManager: ObservableObject {
    
    @Published var conferences = [ConferenceDetails]()
    
    init() {
        guard let url = URL(string: "https://hackertracker.app/conferences.json") else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            let decoded = self.decodeConferences(data: data)
            switch decoded {
            case let .success(decodedData):
                DispatchQueue.main.async {
                    self.conferences = decodedData.conferences
                }
            case let .failure(error):
                print(error)
                return
            }
        }.resume()
    }
    
    func decodeConferences(data: Data) -> Result<HTConferences, HTError> {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let decoded = try? decoder.decode(HTConferences.self, from: data) else { return .failure(.decodeError) }
        return .success(decoded)
        
    }
}

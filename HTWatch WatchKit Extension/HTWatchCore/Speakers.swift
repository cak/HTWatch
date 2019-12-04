import Foundation

public struct HTSpeakers: Decodable {
    public var speakers: [Speakers]
    public var updatedAt: String
}

public struct Speakers: Decodable, Identifiable  {
    public var link: String
    public var updatedAt: String
    public var conference: String
    public var description: String
    public var twitter: String
    public var id: Int
    public var title: String
    public var name: String
}

class SpeakersManager: ObservableObject {
    
    @Published var speakers = [Speakers]()
    
    
    init(event: String) {
        guard let url = URL(string: "https://hackertracker.app/\(event)/speakers.json") else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            let decoded = self.decodeHTSpeakers(data: data)
            switch decoded {
            case let .success(decodedData):
                DispatchQueue.main.async {
                    self.speakers = decodedData.speakers
                }
            case let .failure(error):
                print(error)
                return
            }
        }.resume()
    }
    
    func decodeHTSpeakers(data: Data) -> Result<HTSpeakers, HTError> {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let decoded = try? decoder.decode(HTSpeakers.self, from: data) else { return .failure(.decodeError) }
        return .success(decoded)
        
    }
}


func lookupSpeakers(id: [Int], speakers: [Speakers]) -> String {
    return speakers.filter( { id.contains($0.id) }).map({ $0.name }).joined(separator: ", ")
}

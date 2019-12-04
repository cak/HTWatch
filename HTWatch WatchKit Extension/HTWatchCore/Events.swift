import Foundation
import Combine

public struct HTEvents: Decodable {
    public var schedule: [Schedules]
    public var updatedAt: String
}

public struct Schedules: Decodable, Identifiable {
    public var speakers: [Int]
    public var location: Int
    public var link: String
    public var updatedAt: String
    public var id: Int
    public var title: String
    public var description: String
    public var startDate: String
    public var conference: String
    public var eventType: Int
    public var endDate: String
    public var includes: String
}

class EventsManager: ObservableObject {
    
    @Published var schedules = [Schedules]()
    
    
    init(event: String) {
        guard let url = URL(string: "https://hackertracker.app/\(event)/events.json") else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            let decoded = self.decodeEvents(data: data)
            switch decoded {
            case let .success(decodedData):
                DispatchQueue.main.async {
                    self.schedules = decodedData.schedule
                }
            case let .failure(error):
                print(error)
                return
            }
        }.resume()
    }
    
    func decodeEvents(data: Data) -> Result<HTEvents, HTError> {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let decoded = try? decoder.decode(HTEvents.self, from: data) else { return .failure(.decodeError) }
        return .success(decoded)
        
    }
}

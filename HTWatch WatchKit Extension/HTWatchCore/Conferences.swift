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
    
    private var searchCancellable: Cancellable? {
        didSet { oldValue?.cancel() }
    }
    
    deinit {
        searchCancellable?.cancel()
    }
    
    init() {
        guard let url = URL(string: "https://hackertracker.app/conferences.json") else { return }
        searchCancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data}
            .decode(type: HTConferences.self, decoder: decoder())
            .map { $0.conferences}
            .replaceError(with: [ConferenceDetails]())
            .receive(on: RunLoop.main)
            .assign(to: \.conferences, on: self)
    }
}

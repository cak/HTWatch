import SwiftUI

struct EventDetailView: View {
    var event: Schedules
    var conference: String
    @ObservedObject var speakers: SpeakersManager
    @ObservedObject var locations: LocationsManager
    
    var body: some View {
        ScrollView {
            VStack {
                Text(event.title).bold().multilineTextAlignment(.center).layoutPriority(1)
                Spacer()
                Text(event.description).font(.footnote)
                    .foregroundColor(.gray)
                    .lineLimit(15)
                Spacer()
                Text(lookupSpeakers(id: self.event.speakers, speakers: speakers.speakers)).font(.body)
                Spacer()
                Text(lookupLocation(id: self.event.location, location: locations.locations)).font(.body)
                
            }
        }
    }
}

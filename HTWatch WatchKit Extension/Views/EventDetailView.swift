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
                if !event.description.isEmpty {
                    Text(event.description).font(.footnote)
                        .foregroundColor(.gray)
                        .lineLimit(50)
                    Spacer()
                }
                if !event.speakers.isEmpty {
                    Text("Speakers").font(.subheadline).bold()
                    Text(lookupSpeakers(id: self.event.speakers, speakers: speakers.speakers)).font(.footnote)
                }
                Spacer()
                Text("Location").font(.subheadline).bold()
                Text(lookupLocation(id: self.event.location, location: locations.locations)).font(.footnote)
                
            }
        }
    }
}

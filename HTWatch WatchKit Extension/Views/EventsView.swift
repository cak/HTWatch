import SwiftUI

struct EventsView: View {
    var event: String
    var eventCode: String
    @ObservedObject var schedules: EventsManager
    
    var body: some View {
        VStack {
            Text(event).bold()
            List {
                ForEach(schedules.schedules.sorted {
                    $0.startDate < $1.startDate }, id: \.id) { event in
                        VStack(alignment: .leading) {
                            NavigationLink(event.title, destination:
                                EventDetailView(event: event, conference: self.event, speakers: SpeakersManager(event: self.eventCode), locations: LocationsManager(event: self.eventCode)))
                            Text(DateDecoding(event.startDate).event())
                        }
                }
            }
        }
    }
}

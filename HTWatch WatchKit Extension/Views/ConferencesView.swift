import SwiftUI

struct ConferencesView: View {
    @ObservedObject var conferences = ConferencesManager()
    
    var body: some View {
        VStack {
            Text("Conferences").bold()
            List {
                ForEach(conferences.conferences.sorted {
                    $0.startDate < $1.startDate }, id: \.id) { conference in
                        VStack(alignment: .leading) {
                            NavigationLink(conference.name, destination:
                                EventsView(event: conference.name, eventCode: conference.code,
                                           schedules:
                                    EventsManager(event: conference.code)))
                            Text(DateDecoding(conference.startDate).conference()).font(.footnote)
                        }
                }
            }
        }
    }
}

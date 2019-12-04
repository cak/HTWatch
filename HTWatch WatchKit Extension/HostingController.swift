import WatchKit
import Foundation
import SwiftUI

class HostingController: WKHostingController<ConferencesView> {
    override var body: ConferencesView {
        return ConferencesView()
    }
}

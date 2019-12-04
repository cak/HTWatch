import Foundation

struct DateDecoding {
    
    let date: String
    
    init(_ date: String) {
        self.date = date
    }
    
    func event() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mmZZZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        let dateParsed = dateFormatter.date(from: self.date)
        dateFormatter.dateFormat = "E MM/dd h:mm a"
        if let dateParsed = dateParsed {
            return dateFormatter.string(from: dateParsed)
        } else {
            return ""
        }
    }
    
    func conference() -> String {
        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let dateParsed = dateFormatter.date(from: self.date)
            dateFormatter.dateFormat = "MM/dd/YY - MM/dd/YY"
            if let dateParsed = dateParsed {
                return dateFormatter.string(from: dateParsed)
            } else {
                return ""
            }
        }
}

import Foundation

public struct HTEventTypes: Decodable {
    public var eventTypes: [EventTypes]
    public var updatedAt: String
}

public struct EventTypes: Decodable {
    public var updatedAt: String
    public var color: String
    public var id: Int
    public var conference: String
    public var name: String
}

public func getEventTypes(url: String, completion: @escaping (Result<HTEventTypes, HTError>) -> Void) {
    get(url: url) { result in
        switch result {
        case let .success(data):
            let decoded = decodeEventTypes(data: data)
            switch decoded {
            case let .success(decodedData):
                completion(.success(decodedData))
            case let .failure(error):
                completion(.failure(error))
            }

        case let .failure(error):
            completion(.failure(error))
        }
    }
}

func decodeEventTypes(data: Data) -> Result<HTEventTypes, HTError> {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    guard let decoded = try? decoder.decode(HTEventTypes.self, from: data) else { return .failure(.decodeError) }
    return .success(decoded)
}

import Foundation

public struct HTArticles: Decodable {
    public var articles: [Articles]
    public var updatedAt: String
}

public struct Articles: Decodable {
    public var updatedAt: String
    public var text: String
    public var id: Int
    public var name: String
    public var conference: String
}

public func getArticles(url: String, completion: @escaping (Result<HTArticles, HTError>) -> Void) {
    get(url: url) { result in
        switch result {
        case let .success(data):
            let decoded = decodeArticles(data: data)
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

func decodeArticles(data: Data) -> Result<HTArticles, HTError> {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    guard let decoded = try? decoder.decode(HTArticles.self, from: data) else { return .failure(.decodeError) }
    return .success(decoded)
}

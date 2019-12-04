import Foundation

public enum HTError: Error {
    case invalidURL
    case networkError
    case decodeError
}

func get(url: String, completion: @escaping (Result<Data, HTError>) -> Void) {
    guard let url = URL(string: url) else {
        completion(.failure(.invalidURL))
        return
    }

    let request = URLRequest(url: url)

    URLSession.shared.dataTask(with: request) { data, _, error in
        if error != nil {
            completion(.failure(.networkError))
        }
        if let data = data {
            completion(.success(data))
        }
    }.resume()
}

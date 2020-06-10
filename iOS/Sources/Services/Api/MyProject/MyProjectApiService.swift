import Foundation
import Combine
import MyProjectApi

final class MyProjectApiService: ApiServiceInterface {
	let baseURL: URL

	init(baseURL: URL) {
		self.baseURL = baseURL
	}

	func getBlogPosts() -> AnyPublisher<Page<BlogPostListObject>, HTTP.Error> {
		let url = baseURL
			.appendingPathComponent("blog")
			.appendingPathComponent("posts")

		var request = URLRequest(url: url)
		request.httpMethod = HTTP.Method.get.rawValue.uppercased()

		let decoder = JSONDecoder()
		decoder.dateDecodingStrategy = .iso8601

		return URLSession.shared.dataTaskPublisher(for: request)
			.tryMap { data, response in
				guard let httpResponse = response as? HTTPURLResponse else {
					throw HTTP.Error.invalidResponse
				}
				guard httpResponse.statusCode == 200 else {
					throw HTTP.Error.statusCode(httpResponse.statusCode)
				}
				return data
			}
			.decode(type: Page<BlogPostListObject>.self, decoder: decoder)
			.mapError { error -> HTTP.Error in
				guard let httpError = error as? HTTP.Error else {
					return HTTP.Error.unknown(error)
				}
				return httpError
			}
			.eraseToAnyPublisher()
	}
}

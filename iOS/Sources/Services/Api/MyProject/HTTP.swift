import Foundation

enum HTTP {
	enum Method: String {
		case get
		case post
		case put
		case patch
		case delete
	}

	enum Error: LocalizedError {
		case invalidResponse
		case statusCode(Int)
		case unknown(Swift.Error)
	}
}

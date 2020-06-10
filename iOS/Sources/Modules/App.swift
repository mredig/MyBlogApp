import Foundation

final class App {
	
	let services: ServiceBuilderInterface
	static let shared = App()

	private init() {
		services = ServiceBuilder()
	}

	func setup() {
		services.setup()
	}
}

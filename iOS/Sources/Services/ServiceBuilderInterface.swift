import Foundation

protocol ServiceBuilderInterface {

	var api: ApiServiceInterface { get }

	func setup()
}

extension ServiceBuilderInterface {
	func setup() {
		self.api.setup()
	}
}

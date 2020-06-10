import Foundation

final class ServiceBuilder: ServiceBuilderInterface {
	lazy var api: ApiServiceInterface = {
		MyProjectApiService(baseURL: URL(string: "http://137.220.58.247:8080/api")!)
	}()
}

//
//  ViewController.swift
//  MyBlogApp
//
//  Created by Michael Redig on 6/9/20.
//  Copyright © 2020 Red_Egg Productions. All rights reserved.
//

import UIKit
import Combine

class ViewController: UIViewController {

	var operations: [String: AnyCancellable] = [:]

	override func viewDidLoad() {
		super.viewDidLoad()

//		let url = URL(string: "http://137.220.58.247:8080/api")!
		let url = URL(string: "http://localhost:8080/api")!

		let api = MyProjectApiService(baseURL: url)

		operations["posts"] = api.getBlogPosts()
			.receive(on: DispatchQueue.main)
			.sink(receiveCompletion: { [weak self] completion in
				switch completion {
				case .finished:
					break
				case .failure(let error):
					print(error)
				}
				self?.operations["posts"] = nil
				}, receiveValue: { page in
					print(page)
			})
	}
}


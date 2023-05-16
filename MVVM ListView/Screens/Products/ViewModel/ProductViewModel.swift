////
////  ProductViewModel.swift
////  MVVM ListView
////
////  Created by Aashish Ahlawat on 16/05/23.
////
//
//import Foundation
//
//class ProductViewModel {
//    var products : [Product] = []
//    @Published var eventHandler : ((_ event : Event) -> Void)?
//
//    func fetchProducts() {
//        self.eventHandler?(.loading)
//        APIManager.shared.fetchProducts { response in
//            self.eventHandler?(.stopLoading)
//            switch response {
//            case .success(let products):
//                self.products = products
//                self.eventHandler?(.dataLoaded)
//            case .failure(let error):
//                self.eventHandler?(.error(error))
////                print(error)
//            }
//        }
//    }
//
//}
//
//extension ProductViewModel {
//    enum Event {
//        case loading
//        case stopLoading
//        case dataLoaded
//        case error(Error?)
//    }
//}



import Foundation
import Combine

class ProductViewModel {
    @Published var products: [Product] = []
    @Published var isLoading: Bool = false
    @Published var error: Error?

    private var cancellables = Set<AnyCancellable>()

    func fetchProducts() {
        isLoading = true
        APIManager.shared.fetchProducts { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false

            switch result {
            case .success(let products):
                self.products = products
            case .failure(let error):
                self.error = error
            }
        }
    }
}

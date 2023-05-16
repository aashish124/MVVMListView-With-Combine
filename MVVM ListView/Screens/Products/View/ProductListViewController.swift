////
////  ProductListViewController.swift
////  MVVM ListView
////
////  Created by Aashish Ahlawat on 16/05/23.
////
//
//import UIKit
//import Combine
//
//class ProductListViewController: UIViewController {
//
//    @IBOutlet weak var productTableView : UITableView!
//
//    private var viewModel = ProductViewModel()
//
//    private var cancellables : Set<AnyCancellable> = []
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        configure()
//    }
//
//    func configure() {
//        productTableView.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ProductCell")
//        initViewModel()
//        observeEvent()
//    }
//
//    func initViewModel() {
//        viewModel.fetchProducts()
//    }
//    func observeEvent() {
//        viewModel.$eventHandler.sink { [weak self] event in
//            guard let self = self else { return }
//
//            switch event {
//            case .loading:
//                /// Indicator show
//                print("Product loading....")
//            case .stopLoading:
//                /// Indicator hide kardo
//                print("Stop loading...")
//            case .dataLoaded:
//                print("Data loaded...")
//                print(self.viewModel.products)
//                    DispatchQueue.main.async {
//                        // UI Main works well
//                        self.productTableView.reloadData()
//                    }
//            case .error(let error):
//                print(error)
////                case .newProductAdded(let newProduct):
////                    print(newProduct)
//            }
//        }.store(in: &cancellables)
////        viewModel.eventHandler = {
////        }
//    }
//}
//
//extension ProductListViewController: UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        viewModel.products.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell") as? ProductCell else {
//            return UITableViewCell()
//        }
//        let product = viewModel.products[indexPath.row]
//        cell.product = product
//        return cell
//    }
//
//}





import UIKit
import Combine

class ProductListViewController: UIViewController {

    @IBOutlet weak var productTableView: UITableView!

    private var viewModel = ProductViewModel()
    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        bindViewModel()
    }

    func configure() {
        productTableView.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ProductCell")
        productTableView.dataSource = self
    }

    func bindViewModel() {
        viewModel.fetchProducts()
        viewModel.$products
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.productTableView.reloadData()
            }.store(in: &cancellables)
        
        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                if isLoading {
                    // Show loading indicator
                    print("Product loading....")
                } else {
                    // Hide loading indicator
                    print("Stop loading...")
                }
            }.store(in: &cancellables)

        viewModel.$error
            .receive(on: DispatchQueue.main)
            .sink { error in
                guard let error = error else { return }
                print(error)
            }.store(in: &cancellables)
    }
}

extension ProductListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as? ProductCell else {
            return UITableViewCell()
        }

        let product = viewModel.products[indexPath.row]
        cell.product = product
        return cell
    }
}


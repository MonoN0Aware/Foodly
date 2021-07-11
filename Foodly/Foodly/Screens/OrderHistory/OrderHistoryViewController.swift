//
//  OrderHistoryViewController.swift
//  Foodly
//
//  Created by Decagon on 23.6.21.
//

import UIKit

class OrderHistoryViewController: UIViewController {
    
    @IBOutlet weak var oderHistoryTableView: UITableView!
    let orderHistoryModel = OrderHistoryModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: OrderHistoryTableViewCell.identifier, bundle: nil)
        oderHistoryTableView.register(nib, forCellReuseIdentifier: OrderHistoryTableViewCell.identifier)
        oderHistoryTableView.delegate = self
        oderHistoryTableView.dataSource = self
        
        self.navigationItem.title = "My Order History"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
                self.oderHistoryTableView.reloadData()
        }
    }
}

extension OrderHistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderHistoryModel.orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = oderHistoryTableView.dequeueReusableCell(withIdentifier: OrderHistoryTableViewCell.identifier,
                                                for: indexPath) as? OrderHistoryTableViewCell else {fatalError()}
        
        cell.configure(with: orderHistoryModel.orders[indexPath.row])
        
        return cell
    }
}

extension OrderHistoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
}

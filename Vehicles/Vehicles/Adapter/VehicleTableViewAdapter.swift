//
//  VehicleTableViewAdapter.swift
//  Vehicles
//
//  Created by Ashish Patel on 2021/11/22.
//

/**
 ## VehicleTableViewAdapter
 
 This class provides the reusable component feature.
 Implemented Adapter desing pattern
 
 */

import UIKit

@objc(VehicleTableViewAdapterDelegate)
protocol VehicleTableViewAdapterDelegate {
    func vehicleTableAdapter(_ adapter: VehicleTableViewAdapter,
                             didSelect item: Any)
}

@objcMembers public final class VehicleTableViewAdapter: NSObject {
    private let tableView: UITableView
    private weak var delegate: VehicleTableViewAdapterDelegate?
    private let cellIdentifier = "VehicleListCell"
    var items = [Any]()
    
    init(tableView: UITableView,
         delegate: VehicleTableViewAdapterDelegate?) {
        self.tableView = tableView
        self.delegate = delegate
        super.init()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(VehicleListTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    func setData(data:[Any]) {
        self.items = data
        reloadData()
    }
    
    private func reloadData() {
        UIView.transition(
            with: tableView,
            duration: 0.35,
            options: .curveEaseIn,
            animations: { [self] in
                tableView.reloadData()
            })
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource methods

extension VehicleTableViewAdapter: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView,
                          heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 89
    }
    public func tableView(_ tableView: UITableView,
                          estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    public func tableView(_ tableView: UITableView,
                          numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    public func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? VehicleListTableViewCell
        if let vehicle = items[indexPath.row] as? VehicleModel {
            cell?.populateData(vehicle)
        }
        return cell ?? UITableViewCell()
    }
    
    public func tableView(_ tableView: UITableView,
                          didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.vehicleTableAdapter(self, didSelect: items[indexPath.row])
    }
}

//
//  ImageDetailVC.swift
//  DemoApp
//
//  Created by Giorgi Katamadze on 19.02.23.
//

import UIKit

class ImageDetailVC: UIViewController {

    private let reuseIdentifier = "ImageDetailCell"
    //MARK: - Properties
    private var tableView  :  UITableView!
    var viewModel           = MainPageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        configureTableView()
    }
    
    
    //MARK: - Helpers
    private func configureTableView()  {
        tableView = UITableView(frame: .zero)
        view = tableView
        tableView.backgroundColor  = .white
        tableView.separatorStyle  = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ImageDetailCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.reloadData()
    }
}
//MARK: - UITableViewDelegate , UITableViewDataSource
extension ImageDetailVC : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.imageDetailModel.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.imageDetailModel[section].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ImageDetailCell
        let curr = viewModel.imageDetailModel[indexPath.section][indexPath.row]
        cell.configureDetailUI(with: curr)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let curr = viewModel.imageDetailModel[indexPath.section][indexPath.row]
        return  curr.imageInfo?.key == "imageInfoKey" ? 200 : 120
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return "section \(section )"
    }
}


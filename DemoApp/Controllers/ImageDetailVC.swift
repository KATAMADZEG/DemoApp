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
    }
}
//MARK: - UITableViewDelegate , UITableViewDataSource
extension ImageDetailVC : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ImageDetailCell
//        cell.configureMainPageCellUI()
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
}

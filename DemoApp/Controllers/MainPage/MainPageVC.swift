//
//  MainPageVC.swift
//  DemoApp
//
//  Created by Giorgi Katamadze on 18.02.23.
//

import UIKit

class MainPageVC: UIViewController {

    private let reuseIdentifier = "MainPageCell"
    
    private var tableView  :  UITableView!
    
//MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        tableView.register(MainPageCell.self, forCellReuseIdentifier: reuseIdentifier)
    }

}

//MARK: - UITableViewDelegate , UITableViewDataSource
extension MainPageVC : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! MainPageCell
        cell.configureMainPageCellUI()
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        let vc = ImageDetailVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
}

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
    private var viewModel  = MainPageViewModel()
    
    let web = URLs()
    
//MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        viewModel.outputs = self
        viewModel.inputs.fetchData()
        web.main()
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
        viewModel.mainPageModel.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! MainPageCell
        let curr = viewModel.mainPageModel[indexPath.row]
        cell.configureMainPageCellUI(with: curr)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let curr  = viewModel.mainPageModel[indexPath.row]
        let filetWithId = viewModel.mainPageModel.filter({$0.id == curr.id})
        
        viewModel.imageDetailModel.removeAll()
        filetWithId.forEach { data in
            viewModel.imageDetailModel.append([ImageDetailModel(imageInfo: ImageInfoModel(key: "imageInfoKey",previewURL: data.previewURL,imageSize: data.imageSize, type: data.type, tags:  data.tags))])
            viewModel.imageDetailModel.append([ImageDetailModel(userInfo: UserInfo(key: "userInfoKey",views: data.views, downloads: data.downloads, comments: data.comments, likes: data.likes))])
        }
        let vc = ImageDetailVC()
        vc.viewModel = viewModel
        navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
}

//MARK: - MainPageViewModelOutputs
extension MainPageVC : MainPageViewModelOutputs {
    func response(data: [MainPageModel]) {
        viewModel.mainPageModel = data
        tableView.reloadData()
    }
}


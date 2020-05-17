//
//  MaskViewController.swift
//  TrueLoveProject
//
//  Created by Bomi on 2020/5/6.
//  Copyright © 2020 PrototypeC. All rights reserved.
//

import UIKit
import BTNavigationDropdownMenu

class MaskViewController: UIViewController {

    //for dropdown menu
    let items = ["臺北市", "新北市", "基隆市", "桃園市", "新竹市", "新竹縣", "苗栗縣", "臺中市", "彰化縣", "南投縣", "雲林縣", "嘉義市", "嘉義縣", "臺南市", "高雄市", "屏東縣", "宜蘭縣", "花蓮縣", "臺東縣", "澎湖縣", "金門縣"]
    var menuView: BTNavigationDropdownMenu?
    
    @IBOutlet weak var tableView: UITableView!
    let loadingIndicator = LoadingIndicator()
    var masksList: Array = testData
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationDropdownMenu()
        self.setTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getMaskData()
    }
}


//MARK: tableview delegate, datasource
extension MaskViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return masksList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.Cell.mask,
                                                     for: indexPath) as? MaskTableViewCell
            else { return UITableViewCell() }

        
        return cell
    }
    
}

//MARK: private
extension MaskViewController {
    
    private func setTableView() {
        let gameNib = UINib(nibName: Constant.Cell.mask, bundle: nil)
        self.tableView.register(gameNib, forCellReuseIdentifier: Constant.Cell.mask)
        
        //style
        tableView.separatorStyle = .none
    }
    
    private func setNavigationDropdownMenu() {
        
        menuView = BTNavigationDropdownMenu(title: items[0], items: items as [Any] as! [String])
        self.navigationItem.titleView = menuView
        
        menuView?.didSelectItemAtIndexHandler = { [weak self] (indexPath: Int) -> Void in
            
            if let city = self?.items[indexPath] {
                Constant.DisplaySeletectCity.index = indexPath
                Constant.DisplaySeletectCity.name = city
            }
            //            self?.getInfo()
        }
        
        menuView?.menuTitleColor = .darkGray
        menuView?.arrowTintColor = .darkGray
        menuView?.selectedCellTextLabelColor = .gray
        menuView?.cellTextLabelColor = .white
        menuView?.cellSelectionColor = .gray
        menuView?.cellSeparatorColor = .white
        menuView?.cellBackgroundColor = .darkGray
    }
    
    private func getMaskData() {
        //        self.loadingIndicator.start()
    }

}


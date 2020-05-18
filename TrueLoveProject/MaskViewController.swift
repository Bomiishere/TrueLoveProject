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
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            let gameNib = UINib(nibName: Constant.Cell.mask, bundle: nil)
            self.tableView.register(gameNib, forCellReuseIdentifier: Constant.Cell.mask)
            
            //style
            tableView.separatorStyle = .none
        }
    }
    let loadingIndicator = LoadingIndicator()
    var masksList: Array<Dictionary<String, Any>> = mockData["features"] as! Array
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationDropdownMenu()
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
        return listingCell(tableView, indexPath)
    }
    
    private func listingCell(_ tableView: UITableView, _ indexPath: IndexPath) -> MaskTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.Cell.mask) as! MaskTableViewCell
        
        let model = self.masksList[indexPath.row]
        
        guard
            let maskInfoDic = model["properties"] as? Dictionary<String, Any>,
            let geometryDic = model["geometry"] as? Dictionary<String, Any>
            else {
                return MaskTableViewCell()
        }
        
        let decoder = JSONDecoder()
        
        do {
            let maskData = try JSONSerialization.data(withJSONObject: maskInfoDic, options: .prettyPrinted)

            let coordinateData = try JSONSerialization.data(withJSONObject: geometryDic, options: .prettyPrinted)

            let maskInfos = try decoder.decode(MaskInfos.self, from: maskData)
        
            let geometry = try decoder.decode(Geometry.self, from: coordinateData)
            
            let mask = Mask(info: maskInfos, geometry: geometry)
            
            cell.configure(model: mask)
            
        } catch let DecodingError.dataCorrupted(context) {
            print(context)
        } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.typeMismatch(type, context)  {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print("error: ", error)
        }
        
        //TODO: view model
//        let viewModel = viewModels[indexPath.row]
//        viewModel.configure(cell)
        
        return cell
    }
    
    //TODO: error cell
//    private func errorCell(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
//        return tableView.dequeueReusableCell(withIdentifier: ErrorTableViewCell.identifier, for: indexPath)
//    }
    
}

//MARK: private
extension MaskViewController {
    
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


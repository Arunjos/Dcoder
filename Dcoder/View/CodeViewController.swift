//
//  CodeViewController.swift
//  Dcoder
//
//  Created by Arun Jose on 24/03/19.
//  Copyright © 2019 Arun Jose. All rights reserved.
//

import UIKit
import DropDown

class CodeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var filterOne: UIButton!
    @IBOutlet weak var filterTwo: UIButton!
    @IBOutlet weak var filterOneView: UIView!
    @IBOutlet weak var filterTwoView: UIView!
    @IBOutlet weak var emptyIndicatorLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var codeListTableview: UITableView!
    var viewModel:CodeViewModel = CodeViewModelFromCode()
    
    let dropDownfilter1 = DropDown()
    let dropDownfilter2 = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupViewModel()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setupUI() {
        codeListTableview.register(UINib(nibName: "CodeTableViewCell", bundle: nil), forCellReuseIdentifier: Constants.CODE_CELL_ID)
        codeListTableview.rowHeight = UITableViewAutomaticDimension
        codeListTableview.estimatedRowHeight = UITableViewAutomaticDimension
        
        dropDownfilter1.anchorView = self.filterOneView
        dropDownfilter1.dataSource = CodeViewModelFromCode.filter1DataSource
        dropDownfilter1.selectionAction = { [unowned self] (index: Int, item: String) in
            DispatchQueue.main.async {
                self.filterOne.setTitle(item, for: .normal)
            }
            self.viewModel.filterOneApply(forIndex: index)
        }
        
        dropDownfilter2.anchorView = self.filterTwoView
        dropDownfilter2.dataSource = CodeViewModelFromCode.filter2DataSource
        dropDownfilter2.selectionAction = { [unowned self] (index: Int, item: String) in
            DispatchQueue.main.async {
                self.filterTwo.setTitle(item, for: .normal)
            }
            self.viewModel.filterTwoApply(forIndex: index)
        }
    }
    
    func setupViewModel() {
        viewModel.codeListCount.bind{[unowned self] count in
            DispatchQueue.main.async {
                self.codeListTableview.reloadData()
                if count != 0 {
                    self.codeListTableview.isHidden = false
                    self.emptyIndicatorLabel.isHidden = true
                    self.codeListTableview.scrollToRow(at: IndexPath(row: 0, section: 0), at: .bottom, animated: false)
                }else {
                    self.emptyIndicatorLabel.isHidden = false
                    self.codeListTableview.isHidden = true
                }
            }
        }
        viewModel.isCodeListFetching.bind{[unowned self] show in
            if show{
                self.codeListTableview.isHidden = true
                self.activityIndicator.startAnimating()
            }else{
                DispatchQueue.main.async {
                    self.codeListTableview.isHidden = false
                    self.activityIndicator.stopAnimating()
                }
            }
        }
        viewModel.error.bind{[unowned self] errorMessage in
            let alertController = UIAlertController(title: "Error", message: errorMessage, preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
            
        }
        viewModel.fetchCodeList()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.codeListCount.value
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let codeDetail = viewModel.getCodeDetailForCell(atIndex: indexPath) {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CODE_CELL_ID, for: indexPath) as! CodeTableViewCell
            cell.setupCell(forCode: codeDetail)
            return cell
            
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return UITableViewAutomaticDimension
    }
    
    @IBAction func fileterOneClicked(_ sender: Any) {
        dropDownfilter1.show()
    }
    
    @IBAction func filterTwoClicked(_ sender: Any) {
        dropDownfilter2.show()
    }
    
    func addCode(title:String, code:String, tag:String) {
        viewModel.addCode(title: title, code: code, tag: tag)
    }

}

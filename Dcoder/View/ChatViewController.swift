//
//  ChatViewController.swift
//  Dcoder
//
//  Created by Arun Jose on 23/03/19.
//  Copyright © 2019 Arun Jose. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var chatTextview: UITextView!
    @IBOutlet weak var chatListTableview: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var viewModel:ChatViewModel = ChatViewModelFromChat()
    
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
        chatListTableview.register(UINib(nibName: "MyChatTableViewCell", bundle: nil), forCellReuseIdentifier: Constants.MY_CHAT_CELL_ID)
        chatListTableview.register(UINib(nibName: "OthersChatTableViewCell", bundle: nil), forCellReuseIdentifier: Constants.OTHERS_CHAT_CELL_ID)
        chatListTableview.rowHeight = UITableViewAutomaticDimension
        chatListTableview.estimatedRowHeight = UITableViewAutomaticDimension
    }
    
    func setupViewModel() {
        viewModel.chatCount.bind{[unowned self] count in
            DispatchQueue.main.async {
                self.chatListTableview.reloadData()
                self.chatListTableview.scrollToRow(at: IndexPath(row: count-1, section: 0), at: .bottom, animated: false)
            }
        }
        viewModel.isChatFetching.bind{[unowned self] show in
            if show{
                self.chatListTableview.isHidden = true
                self.activityIndicator.startAnimating()
            }else{
                DispatchQueue.main.async {
                    self.chatListTableview.isHidden = false
                    self.activityIndicator.stopAnimating()
                }
            }
        }
        viewModel.error.bind{[unowned self] errorMessage in
            let alertController = UIAlertController(title: "Error", message: errorMessage, preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
            
        }
        viewModel.fetchChatList()
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return viewModel.chatCount.value
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let chatDetail = viewModel.getChatDataForCell(atIndex: indexPath) {
            if let myMsg = chatDetail.isMyMessage, myMsg == true {
                let myCell = tableView.dequeueReusableCell(withIdentifier: Constants.MY_CHAT_CELL_ID, for: indexPath) as! MyChatTableViewCell
                myCell.setupCell(forChat: chatDetail)
                return myCell
            }else{
                let othersCell = tableView.dequeueReusableCell(withIdentifier: Constants.OTHERS_CHAT_CELL_ID, for: indexPath) as! OthersChatTableViewCell
                othersCell.setupCell(forChat: chatDetail)
                return othersCell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return UITableViewAutomaticDimension
    }
    
    
    @IBAction func chatSentClicked(_ sender: Any) {
        if chatTextview.text != "" {
            viewModel.sentChat(withMessage: chatTextview.text)
            chatTextview.text = ""
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

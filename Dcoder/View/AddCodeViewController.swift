//
//  AddCodeViewController.swift
//  Dcoder
//
//  Created by Arun Jose on 24/03/19.
//  Copyright © 2019 Arun Jose. All rights reserved.
//

import UIKit

class AddCodeViewController: UIViewController {

    @IBOutlet weak var tagTextFiled: UITextField!
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clickedCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func clickedAdd(_ sender: Any) {
        if isVaildFormData() {
            if let presenter = presentingViewController?.childViewControllers[0] as? CodeViewController {
                presenter.addCode(title: titleTextField.text ?? "", code: codeTextField.text ?? "", tag: tagTextFiled.text ?? "")
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func isVaildFormData() -> Bool {
        var isVaild = true
        titleTextField.layer.borderWidth = 0
        if titleTextField.text == "" {
            isVaild = false
            showErrorBorder(textField: titleTextField)
        }
        codeTextField.layer.borderWidth = 0
        if codeTextField.text == "" {
            isVaild = false
            showErrorBorder(textField: codeTextField)
        }
        tagTextFiled.layer.borderWidth = 0
        if tagTextFiled.text == "" {
            isVaild = false
            showErrorBorder(textField: tagTextFiled)
        }
        return isVaild
    }
    
    func showErrorBorder(textField:UITextField) {
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.red.cgColor
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

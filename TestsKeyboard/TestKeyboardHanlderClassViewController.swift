//
//  TestVC.swift
//  TestsKeyboard
//
//  Created by Thaciana Soares Goes de Lima on 9/21/16.
//  Copyright © 2016 Thaciana Soares Goes de Lima. All rights reserved.
//

import UIKit

class TestKeyboardHanlderClassViewController: UIViewController, KeyboardInScrollViewHandlerProtocol, UITextFieldDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    var keyboardInScrollViewHandler: KeyboardInScrollViewHandler?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        keyboardInScrollViewHandler = KeyboardInScrollViewHandler(scrollView: scrollView)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}
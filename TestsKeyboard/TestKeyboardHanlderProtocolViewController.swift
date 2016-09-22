//
//  TestKeyboardHanlderProtocolViewController.swift
//  TestsKeyboard
//
//  Created by Thaciana Soares Goes de Lima on 9/21/16.
//  Copyright © 2016 Thaciana Soares Goes de Lima. All rights reserved.
//

import UIKit

class TestKeyboardHanlderProtocolViewController: UIViewController, KeyboardHandlerWithScrollViewProtocol, UITextFieldDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var keyboardInScrollViewHandlerData: KeyboardHandlerWithScrollViewInProtocolData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardDidShow:"), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardDidHide:"), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}

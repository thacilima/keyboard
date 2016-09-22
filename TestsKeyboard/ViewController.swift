//
//  ViewController.swift
//  TestsKeyboard
//
//  Created by Thaciana Soares Goes de Lima on 9/21/16.
//  Copyright © 2016 Thaciana Soares Goes de Lima. All rights reserved.
//

import UIKit

struct KeyboardHandlerWithScrollViewInViewControllerData {
    
    var oldContentInset: UIEdgeInsets?
    var oldIndicatorInsets: UIEdgeInsets?
    var oldContentOffset: CGPoint?
}

class ViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var keyboardHandler = KeyboardHandlerWithScrollViewInViewControllerData()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        super.viewWillDisappear(animated)

        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }

    func keyboardShow(n: NSNotification) {
        keyboardHandler.oldContentInset = self.scrollView.contentInset
        keyboardHandler.oldIndicatorInsets = self.scrollView.scrollIndicatorInsets
        keyboardHandler.oldContentOffset = self.scrollView.contentOffset
        
        if let d = n.userInfo {
            var r = (d[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
            r = self.scrollView.convertRect(r, fromView: nil)
            self.scrollView.contentInset.bottom = r.size.height
            self.scrollView.scrollIndicatorInsets.bottom = r.size.height
        }
        
    }
    func keyboardHide(n: NSNotification) {
        self.scrollView.contentInset = keyboardHandler.oldContentInset!
        self.scrollView.scrollIndicatorInsets = keyboardHandler.oldIndicatorInsets!
        self.scrollView.contentOffset = keyboardHandler.oldContentOffset!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    @IBAction func unwindToMainViewController(segue: UIStoryboardSegue) {
        //nothing goes here
    }

}


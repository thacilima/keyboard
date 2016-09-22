//
//  Test.swift
//  TestsKeyboard
//
//  Created by Thaciana Soares Goes de Lima on 9/21/16.
//  Copyright © 2016 Thaciana Soares Goes de Lima. All rights reserved.
//

import UIKit

class KeyboardInScrollViewHandler {
    
    let scrollView: UIScrollView
    var keyboardInScrollViewHandlerData: KeyboardInScrollViewHandlerData?
    
    init(scrollView: UIScrollView) {
        self.scrollView = scrollView
        self.registerForKeyBoardNotifications()
    }
    
    deinit {
        self.unregisterForKeyBoardNotifications()
    }
    
    private func registerForKeyBoardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(self.keyboardDidShow(_:)),
                                                         name:UIKeyboardDidShowNotification,
                                                         object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(self.keyboardDidHide(_:)),
                                                         name:UIKeyboardWillHideNotification,
                                                         object: nil)
    }
    
    private func unregisterForKeyBoardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardDidShow(notification: NSNotification) {
        
        self.keyboardInScrollViewHandlerData = KeyboardInScrollViewHandlerData(beforeKeyboardShownContentInset: self.scrollView.contentInset, beforeKeyboardShownIndicatorInsets: self.scrollView.scrollIndicatorInsets, beforeKeyboardShownContentOffset: self.scrollView.contentOffset)
        
        if let userInfoDic = notification.userInfo, keyboardFrameEndValue = userInfoDic[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            var keyboardFrameEndRect = keyboardFrameEndValue.CGRectValue()
            keyboardFrameEndRect = self.scrollView.convertRect(keyboardFrameEndRect, fromView: nil)
            
            self.scrollView.contentInset.bottom = keyboardFrameEndRect.size.height
            self.scrollView.scrollIndicatorInsets.bottom = keyboardFrameEndRect.size.height
        }
        
    }
    
    @objc func keyboardDidHide(notification: NSNotification) {
        
        if let keyboardInScrollViewHandlerData = keyboardInScrollViewHandlerData {
            self.scrollView.contentInset = keyboardInScrollViewHandlerData.beforeKeyboardShownContentInset
            self.scrollView.scrollIndicatorInsets = keyboardInScrollViewHandlerData.beforeKeyboardShownIndicatorInsets
            self.scrollView.contentOffset = keyboardInScrollViewHandlerData.beforeKeyboardShownContentOffset
            
            self.keyboardInScrollViewHandlerData = nil
        }
        
    }
}

protocol KeyboardInScrollViewHandlerProtocol {
    
    var scrollView: UIScrollView! { get set }
    var keyboardInScrollViewHandler: KeyboardInScrollViewHandler? { get set }
}

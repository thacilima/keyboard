//
//  KeyboardInScrollViewHandlerProtocol2.swift
//  TestsKeyboard
//
//  Created by Thaciana Soares Goes de Lima on 9/21/16.
//  Copyright © 2016 Thaciana Soares Goes de Lima. All rights reserved.
//

import UIKit

struct KeyboardInScrollViewHandlerData {
    
    var beforeKeyboardShownContentInset: UIEdgeInsets
    var beforeKeyboardShownIndicatorInsets: UIEdgeInsets
    var beforeKeyboardShownContentOffset: CGPoint
}

protocol KeyboardInScrollViewHandlerProtocol2 {
    
    weak var scrollView: UIScrollView! { get set }
    var keyboardInScrollViewHandlerData: KeyboardInScrollViewHandlerData? { get set }
    
    mutating func keyboardDidShow(notification: NSNotification)
    mutating func keyboardDidHide(notification: NSNotification)
}

extension KeyboardInScrollViewHandlerProtocol2 where Self: UIViewController {
    
    func registerForKeyboardNotification() {
        
        // Crash: Não deixa porque os métodos são mutable
//        NSNotificationCenter.defaultCenter().addObserverForName(UIKeyboardDidShowNotification, object: nil, queue: nil) { notification in
//            self.keyboardDidShow(notification)
//        }
        
        // Crash: Em tempo de execução, não encontra o selector
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardDidShow:"), name: UIKeyboardWillShowNotification, object: nil)
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardDidHide:"), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unregisterForKeyboardNotification() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    mutating func keyboardDidShow(notification: NSNotification) {
        
        let keyboardInScrollViewHandlerData = KeyboardInScrollViewHandlerData(beforeKeyboardShownContentInset: self.scrollView.contentInset, beforeKeyboardShownIndicatorInsets: self.scrollView.scrollIndicatorInsets, beforeKeyboardShownContentOffset: self.scrollView.contentOffset)
        self.keyboardInScrollViewHandlerData = keyboardInScrollViewHandlerData
        
        if let userInfoDic = notification.userInfo, keyboardFrameEndValue = userInfoDic[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            var keyboardFrameEndRect = keyboardFrameEndValue.CGRectValue()
            keyboardFrameEndRect = self.scrollView.convertRect(keyboardFrameEndRect, fromView: nil)
            
            self.scrollView.contentInset.bottom = keyboardFrameEndRect.size.height
            self.scrollView.scrollIndicatorInsets.bottom = keyboardFrameEndRect.size.height
        }
        
    }

    mutating func keyboardDidHide(notification: NSNotification) {
        
        if let keyboardInScrollViewHandlerData = keyboardInScrollViewHandlerData {
            self.scrollView.contentInset = keyboardInScrollViewHandlerData.beforeKeyboardShownContentInset
            self.scrollView.scrollIndicatorInsets = keyboardInScrollViewHandlerData.beforeKeyboardShownIndicatorInsets
            self.scrollView.contentOffset = keyboardInScrollViewHandlerData.beforeKeyboardShownContentOffset
            
            self.keyboardInScrollViewHandlerData = nil
        }
        
    }
}

//
//  ViewController.swift
//  RACTest
//
//  Created by Jackie Zhang on 16/7/20.
//  Copyright © 2016年 Jackie Zhang. All rights reserved.
//

import UIKit
import ReactiveCocoa

class ViewController: UIViewController {

    @IBOutlet var textField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        textField.rac_textSignal().map { text -> AnyObject! in
            return text.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)
        }.filter { length -> Bool in
             length as! Int > 3
        }.subscribeNext { text in
            print (text)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


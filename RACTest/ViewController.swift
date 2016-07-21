//
//  ViewController.swift
//  RACTest
//
//  Created by Jackie Zhang on 16/7/20.
//  Copyright © 2016年 Jackie Zhang. All rights reserved.
//

import UIKit
import ReactiveCocoa
import Result

class ViewController: UIViewController {

    @IBOutlet var textField: UITextField!
    
    var textValue : String! {
        didSet {
            print ("\(textValue)")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        textValue = "test"
        
     /*   let textSignal = textField.rac_textSignal()
        textSignal.map { text -> AnyObject! in
            return text.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)
        }.filter { length -> Bool in
             length as! Int > 3
        }.subscribeNext { text in
            print (text)
        }
        
        let producer = timer(5, onScheduler: QueueScheduler.mainQueueScheduler).take(3)
        producer.startWithSignal { signal, disposable in
            signal.observe { date in
                let d = date.value
                print("\(d)")
            }
            
        }
    
        textValue <~ textSignal.toSignalProducer().map { ($0 as? String) ?? ""}.flatMapError {
            _ in SignalProducer<String, NoError>.empty
        }
 
        textValue.producer.startWithNext { text in
            print ("textvalue put \(text)")
        }
        */
        let textFieldChannel = textField.rac_newTextChannel()
        
        let textValueChannel =
            RACKVOChannel(target: self, keyPath: "textValue", nilValue: "")["followingTerminal"]
        textFieldChannel.subscribe(textValueChannel)
        textValueChannel.subscribe(textFieldChannel)
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


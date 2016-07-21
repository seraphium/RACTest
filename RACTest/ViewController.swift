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

struct RAC  {
    var target : NSObject!
    var keyPath : String!
    var nilValue : AnyObject!
    
    init(_ target: NSObject!, _ keyPath: String, nilValue: AnyObject? = nil) {
        self.target = target
        self.keyPath = keyPath
        self.nilValue = nilValue
    }
    
    func assignSignal(signal : RACSignal) {
        signal.setKeyPath(self.keyPath, onObject: self.target, nilValue: self.nilValue)
    }
}

func RACObserve(target: NSObject!, keyPath: String) -> RACSignal  {
    return target.rac_valuesForKeyPath(keyPath, observer: target)
}

infix operator ~> {}
func ~> (signal: RACSignal, rac: RAC) {
    rac.assignSignal(signal)
}


class ViewController: UIViewController {

    @IBOutlet var textField: UITextField!
    
    @IBOutlet weak var button: UIButton!
    
    dynamic var textValue : String! {
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
         //one type of two-way binding
        */
  /*     let textFieldChannel = textField.rac_newTextChannel()
        
        let textValueChannel =
            RACKVOChannel(target: self, keyPath: "textValue", nilValue: "")["followingTerminal"]
        textFieldChannel.subscribe(textValueChannel)
        textValueChannel.subscribe(textFieldChannel)
 */
        //another type of two-way binding
        textField.rac_textSignal() ~> RAC(self, "textValue", nilValue: "")
        RACObserve(self, keyPath: "textValue").skip(1).subscribeNext { text in
            self.textField.text = text as? String
        }

        textValue = "he4llo"

        button.rac_command = RACCommand { object -> RACSignal! in
            self.textValue = "changed"
            return RACSignal.empty()
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


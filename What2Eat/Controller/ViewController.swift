//
//  ViewController.swift
//  What2Eat
//
//  Created by 林海峰 on 2018/7/4.
//  Copyright © 2018年 Stanford University. All rights reserved.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController, ReloadDataDelegate {
    func updateData(data: [String]) {
        foods = data
        print("Foods updated successfully!!!!!")
    }
    

    let defaults = UserDefaults.standard
    var foods = [String]()
    
    var count = 0
    //let foods = ["黄焖杏鲍菇", "香菇面", "麻辣烫", "麻辣香锅", "烤肉饭", "米饭套餐", "牛肉汤", "米线"]
    @IBOutlet weak var food: UILabel!
    @IBOutlet weak var picktime: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        pickAFood()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func tryAgain(_ sender: UIButton) {
        pickAFood()
        
    }
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        pickAFood()
    }
    func pickAFood() {
        count += 1
        if count <= 5 {
            picktime.text = "你已经摇了\(count)次了"
        } else if count <= 10 {
            picktime.text = "你他妈有完没完了，你已经摇了\(count)次了！！"
        } else {
            picktime.text = "你要我干嘛？摇着玩呢？"
        }
        let index = Int(arc4random_uniform(UInt32(foods.count)));
        food.text = foods[index]
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
    
    func loadData() {
        if let data = defaults.array(forKey: "myItems") {
            foods = data as! [String]
        } else {
            foods = ["黄焖杏鲍菇", "香菇面", "麻辣烫", "麻辣香锅", "烤肉饭", "米饭套餐", "牛肉汤", "米线"]
            defaults.set(foods, forKey: "myItems")
        }
    }

}


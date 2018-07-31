//
//  TableViewController.swift
//  What2Eat
//
//  Created by David on 2018/7/31.
//  Copyright © 2018年 Stanford University. All rights reserved.
//

import UIKit

protocol ReloadDataDelegate {
    func updateData(data:[String])
}

class TableViewController: UITableViewController {

    var delegate: ReloadDataDelegate?
    let defaults = UserDefaults.standard
    var items = [String]()
    @IBAction func disMiss(_ sender: UIBarButtonItem) {
        delegate?.updateData(data: items)
        print("delegate activated!")
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func addNewItem(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "你要加个啥啊？", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "添加", style: .default) { (action) in
            if textField.text == "" {
                self.items.append("一个你不知道名字的菜")
            } else {
                self.items.append(textField.text!)
            }
            self.save()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "一个菜名"
            alertTextField.keyboardType = .default
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
  
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }



    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "你要删除这个菜嘛？", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "确定", style: .destructive) { (action) in
            self.items.remove(at: indexPath.row)
            self.save()
        }
        let cancel = UIAlertAction(title: "算了吧", style: .cancel, handler: nil)
        alert.addAction(action)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }

    func save() {
        defaults.set(self.items, forKey: "myItems")
        tableView.reloadData()
    }
    func loadData() {
        if let data = defaults.array(forKey: "myItems") {
            items = data as! [String]
        } else {
            items = [String]()
        }
    }

}

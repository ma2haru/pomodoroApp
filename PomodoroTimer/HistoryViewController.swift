//
//  HistoryViewController.swift
//  PomodoroTimer
//
//  Created by matsumoto miharu on 2019/03/04.
//  Copyright © 2019年 ポモポモ. All rights reserved.
//

import UIKit
import RealmSwift

class HistoryViewController: UITableViewController{

    @IBOutlet weak var table: UITableView!
    var historyList: Results<DoHistory>!
    // Sectionで表示する配列
    private let mySection: NSArray = ["日付", "達成したいこと", "経過時間"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.dataSource = self
        table.delegate = self
        // 永続化されているデータを取りだす
        do{
            let realm = try! Realm()
            historyList = realm.objects(DoHistory.self)
            for history in historyList {
                print("name: \(history.title)")
            }
            tableView.reloadData()
        }catch{
            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let title = historyList.last?.title
//        table.text = title
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Sectionの数を返す
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return mySection.count
    }
    
    // Cellに表示する数を返す
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return historyList.count
        } else if section == 1 {
            return historyList.count
        } else {
            return 0
        }
    }

}

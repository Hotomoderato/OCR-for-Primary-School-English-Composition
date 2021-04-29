//
//  EntryViewController.swift
//  LoTsProject
//
//  Created by lots on 2021/2/26.
//
//

import UIKit

class EntryViewController: UIViewController {
    
    // MARK: - LazyLoad
    
    var tableView = UITableView()
    
    var historyArray = [LPUser]()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        
        setUpData()
    }
}

// MARK: - 设置 UI 界面
extension EntryViewController {
    
    fileprivate func setUpUI() {
        
        view.backgroundColor = .white
        title = "历史成绩"
        
        tableView = UITableView(frame: CGRect(x: 0, y: KNavH, width: ScreenWidth, height: ScreenHeight - KNavH - 20), style: .plain)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(UINib.init(nibName: "HistoryScoreCell", bundle: .main), forCellReuseIdentifier: "HistoryScoreCell")
    }
    
    
    // MARK: - 初始化数据
    func setUpData() {
        
        historyArray.removeAll()
        for item in AppDelegate().manager.select(fromTable: AppDelegate().SqlTableUser) {
    
            let model = LPUser()
            model.account = item["account"] as! String
            model.score = item["score"] as! String
            model.text = item["text"] as! String
            historyArray.append(model)
        }
        tableView.reloadData()
    }
    
}


extension EntryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryScoreCell", for: indexPath) as! HistoryScoreCell
        cell.accountLabel.text = historyArray[indexPath.row].account
        cell.scoreLabel.text = "评分：\(historyArray[indexPath.row].score)"
        cell.contentLabel.text = historyArray[indexPath.row].text
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let attributes = [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 16)]
        let height = historyArray[indexPath.row].text.boundingRect(with: CGSize(width: ScreenWidth - 24, height: CGFloat(MAXFLOAT)), options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: attributes,context: nil).height
        
        return 70 + height
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool{
        return true
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String?{
        return "删除"
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == UITableViewCell.EditingStyle.delete {
            AppDelegate().manager.delete(historyArray[indexPath.row], fromTable: AppDelegate().SqlTableUser)
            setUpData()
            view.makeToast("删除成功")
        }
    }
    
    
}


//
//  ViewController.swift
//  NetWorkCore
//
//  Created by seongbrave on 04/18/2018.
//  Copyright (c) 2018 seongbrave. All rights reserved.
//

import RxSwift
import UtilCore
import NetWorkCore

/**
 owner:cy
 update:2018年04月19日09:52:50
 info: 测试界面
 */
class Test_Vc: Base_Vc {
    
    /****************************Storyboard UI设置区域****************************/
    @IBOutlet weak var test_Tv: UITableView!
    
    
    /*----------------------------   自定义属性区域    ----------------------------*/
    
    let dataSource = ["普通网络请求","流式网络请求","约定好返回数据状态","发起请求然后界面直接得到的是model"]
    
    /****************************Storyboard 绑定方法区域****************************/
    
    
    
    /**************************** 以下是方法区域 ****************************/
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    /**
     界面基础设置
     */
    override func setupUI() {
        
    }
    /**
     app 主题 设置
     */
    override func setViewTheme(){
        
    }
    /**
     绑定到viewmodel 设置
     */
    override func bindToViewModel(){
        
    }
    
}


// MARK: UITableViewDelegate
extension Test_Vc :UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "tcellid", for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row]
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
// MARK: UITableViewDelegate
extension Test_Vc: UITableViewDelegate {
    /// 点击行事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        switch indexPath.row {
        case 0:
            request0()
        case 1:
            request1()
        case 2:
            request2()
        case 3:
            request3()
        default:
            request0()
        }
    }
    
}

extension Test_Vc{
    /// 发起普通的网络请求
    func request0()  {
        NetWorkAPI.sharedInstance.requestSwiftyJSONReg(Api.topics) { (result) in
            switch result {
            case .success(let repos):
                print(repos)
            case .failure(let error):
                print(error)
            }
        }
    }
    /// 流式网络请求
    func request1()  {
        Observable.just("")
            .map { _ in Api.topics}
            .emeRequestApiForJson().subscribe(onNext: {(result) in
                switch result {
                case .success(let data):
                    print(data)
                case .failure(let error):
                    print(error)
                }
            })
            .disposed(by: disposeBag)

    }
    /// 约定好返回数据状态
    func request2()  {
        Observable.just("")
            .map { _ in Api.topics}
            .emeRequestApiForRegJson()
            .subscribe(onNext: {(result) in
                switch result {
                case .success(let data):
                    print(data)
                case .failure(let error):
                    print(error)
                }
            })
            .disposed(by: disposeBag)
    }
    /// 发起请求然后界面直接得到的是model
    func request3()  {
        Observable.just("")
            .map { _ in Api.topics}
            .emeRequestApiForArray(TopicsModel.self)
            .subscribe(onNext: {(result) in
                switch result {
                case .success(let data):
                    print(data)
                case .failure(let error):
                    print(error)
                }
            })
            .disposed(by: disposeBag)
    }
}

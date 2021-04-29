//
//  ScoreViewController.swift
//  LoTsProject
//
//  Created by lots on 2021/3/5.
//
//

import UIKit

class ScoreViewController: UIViewController {
    
    // MARK: - LazyLoad
    @IBOutlet weak var contentView: UITextView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
    }
}

// MARK: - 设置 UI 界面
extension ScoreViewController {
    
    fileprivate func setUpUI() {
        
        view.backgroundColor = .white
        title = "评分"
        contentView.isEditable = false
        contentView.text = "Nowadays, pets become so close and friendly to our human-beings that more and more people enjoy keeping them. Pets can bring them a lot of joys and happiness, because playing with pets is a good way to communicate with the nature. Besides, pets can comfort old people who live alone. With the companion of pets, they won’t feel lonely. Nevertheless, I’m not interested in keeping pets at all. For one thing, keeping pets is bad for environmental protection, since pets usually make a lot of noise and contaminate the roads. For another, the virus carried by pets may cause fatal disease. What’s more, sometimes pets may attack people when they are unhappy. Consequently, we had better not keep too many pets, so as to ensure our health and security. Besides, those pet lovers must take some effective measures to prevent their pets from hurting people and polluting our environment."
        scoreLabel.text = ""
        commentLabel.text = ""
        
        setUpTestUrl()
        
        setUpNav()
    }
    
    
    func setUpNav() {
    
        let LogButton = UIButton(type: .custom)
        LogButton.setTitle("保存", for: .normal)
        LogButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        LogButton.setTitleColor(.black, for: .normal)
        LogButton.contentHorizontalAlignment = .left
        LogButton.sizeToFit()
        LogButton.addTarget(self, action: #selector(saveClick), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: LogButton)
    }
    
    
    // MARK: - 保存历史
    @objc func saveClick() {
        
        if scoreLabel.text?.count == 0 ||  scoreLabel.text?.count == 0 {
            let tipAlter = UIAlertController(title: "提示", message: "请等待点评", preferredStyle: .alert)
            let okAlertAction = UIAlertAction(title: "好的", style: .default){_ in }
            tipAlter.addAction(okAlertAction)
            present(tipAlter, animated: true, completion: nil)
            return
        }
        
        let model = LPUser()
        model.account = "用户\(AppDelegate().manager.select(fromTable: AppDelegate().SqlTableUser).count)"
        model.score = scoreLabel.text!
        model.text = contentView.text!
        AppDelegate().manager.insert(model , intoTable: AppDelegate().SqlTableUser)
        view.makeToast("保存成功")
        
    }
    
    
    // MARK: - 作文点评
    func setUpTestUrl() {
        
        let postData = ["Content" : contentView.text]
        let data = try! JSONSerialization.data(withJSONObject: postData,
                                                           options: .fragmentsAllowed)
        let contentStr = String(data: data, encoding: .utf8)
        
        let secretId  = "AKIDqSp3MOveHl1fI6HaSEB7rvqzsVtQEnJy"
        let secretKey = "WmkjHYZVPULAByVl36PUOSHrA0vayEG2"

        let action = "ECC"
        let service = "ecc"
        let host = "ecc.tencentcloudapi.com"
        let algorithm = "TC3-HMAC-SHA256"
        let version = "2018-12-13"
        let region = "ap-guangzhou"
        
        let timestampInterval: TimeInterval = Date().timeIntervalSince1970
        let timestamp = "\(Int(timestampInterval))"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        //注意时区，否则容易出错
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        let date = dateFormatter.string(from: Date(timeIntervalSince1970: timestampInterval))
        
        
        // ************* 步骤 1：拼接规范请求串 *************

        let httpRequestMethod = "POST"
        let canonicalUri = "/"
        let canonicalQueryString = ""
        let canonicalHeaders = "content-type:application/json\n" + "host:" + host + "\n"
        let signedHeaders = "content-type;host"
        let payload = contentStr!
        let hashedRequestPayload = payload.hashHex(by: .SHA256)
        let canonicalRequest = httpRequestMethod + "\n" + canonicalUri + "\n" + canonicalQueryString + "\n"
            + canonicalHeaders + "\n" + signedHeaders + "\n" + hashedRequestPayload;
        print("第一步结果：", canonicalRequest)

        // ************* 步骤 2：拼接待签名字符串 *************
        let credentialScope = date + "/" + service + "/" + "tc3_request"
        let hashedCanonicalRequest = canonicalRequest.hashHex(by: .SHA256)
        let stringToSign = algorithm + "\n" + timestamp + "\n" + credentialScope + "\n" +
        hashedCanonicalRequest
        print("第二步结果：", stringToSign)

        // ************* 步骤 3：计算签名 *************
        let secretDate = date.hmac(by: .SHA256, key: ("TC3" + secretKey).bytes)
        let secretService = service.hmac(by: .SHA256, key: secretDate)
        let secretSigning = "tc3_request".hmac(by: .SHA256, key: secretService)
        let signature = stringToSign.hmac(by: .SHA256, key: secretSigning).hexString.lowercased()
        print("第三步结果：", signature)

        // ************* 步骤 4：拼接 Authorization *************
        let authorization = "TC3-HMAC-SHA256 " + "Credential=" + secretId + "/" + credentialScope + ", "
        + "SignedHeaders=" + signedHeaders + ", " + "Signature=" + signature
        print("第四步结果：", authorization)
        
        var headerParams = [String: String]()
        headerParams["Host"]           = host
        headerParams["Authorization"]  = authorization
        headerParams["Content-Type"]   = "application/json"
        headerParams["X-TC-Action"]    = action
        headerParams["X-TC-Timestamp"] = timestamp
        headerParams["X-TC-Version"]   = version
        headerParams["X-TC-Region"]    = region
        
        
        let loadUrlStr = "https://ecc.tencentcloudapi.com/"
        let url : URL =  URL(string: loadUrlStr)! as URL
        var requestLoad = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30)
        for headerParam in headerParams {
            requestLoad.setValue(headerParam.value, forHTTPHeaderField: headerParam.key)
        }
        requestLoad.httpMethod = httpRequestMethod
        requestLoad.httpBody = data
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: requestLoad) {[weak self](data, respons, error) in
            guard let self = self else{ return }
            print(error as Any)
            if data == nil {return}
            if respons == nil {return}
            DispatchQueue.main.async {
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                    let dict = json as! Dictionary<String, Any>
                    print(json)
                    
                    self.view.makeToast("点评成功")
                    let response = dict["Response"] as! Dictionary<String, Any>
                    let data = response["Data"] as! Dictionary<String, Any>
                    self.scoreLabel.text = "分数：\(data["Score"]!)"
                    self.commentLabel.text = "点评：\(data["Comment"]!)"
                }catch _ {
                   print("error")
                }
            }
        }
        dataTask.resume()
    }
}

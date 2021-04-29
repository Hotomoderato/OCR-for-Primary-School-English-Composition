//
//  ViewController.swift
//  LoTsProject
//
//  Created by lots on 2021/2/26.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    @IBOutlet weak var showImaeView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

    }

    
    // MARK: - 识别
    @IBAction func identifyClick(_ sender: Any) {
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let  cameraPicker = UIImagePickerController()
            cameraPicker.delegate = self
            cameraPicker.allowsEditing = true
            cameraPicker.sourceType = .camera
            cameraPicker.modalPresentationStyle = .fullScreen
            self.present(cameraPicker, animated: true, completion: nil)
        } else {
            print("不支持拍照")
            let tipAlter = UIAlertController(title: "提示", message: "不支持拍照", preferredStyle: .alert)
            let okAlertAction = UIAlertAction(title: "好的", style: .default){_ in }
            tipAlter.addAction(okAlertAction)
            present(tipAlter, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("获得照片============= \(info)")
        let image : UIImage = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
        showImaeView.image = image
        dismiss(animated: true, completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.showImaeView.image = nil
        }
        
    }
    
    
    // MARK: - 评分
    @IBAction func errorCorrectionClick(_ sender: Any) {
        
        let scoreVc = ScoreViewController()
        navigationController?.pushViewController(scoreVc, animated: true)
    }
    
    // MARK: - 成绩
    @IBAction func resultsClick(_ sender: Any) {
        
        let historyVc = EntryViewController()
        navigationController?.pushViewController(historyVc, animated: true)
        
    }

}



//
//  PostCommentViewController.swift
//  Instagram
//
//  Created by オフショア　テスト用 on 2021/08/18.
//

import UIKit
import Firebase
import SVProgressHUD

class PostCommentViewController: UIViewController {

    var ReceviedData : PostData?
    
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func handlePostButton(_ sender: Any) {
 
        // HUDで投稿処理中の表示を開始
        SVProgressHUD.show()
        
        // 配列からタップされたインデックスのデータを取り出す
        let postData = ReceviedData
        var cmtdata = postData?.comments
        let docid = postData?.id
        let username = Auth.auth().currentUser?.displayName
        
        if cmtdata! == "" {
            cmtdata! = username! + ":" + textField.text!
        }else{
            cmtdata! = cmtdata! + "\n" + username! + ":" + textField.text!
        }
        let postRef = Firestore.firestore().collection(Const.PostPath).document(docid!)
        postRef.updateData(["comments":cmtdata!])
        
        // HUDで投稿完了を表示する
        SVProgressHUD.showSuccess(withStatus: "投稿しました")
        // 投稿処理が完了したので先頭画面に戻る
        UIApplication.shared.windows.first{ $0.isKeyWindow }?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func handleCancelButton(_ sender: Any) {
        print(ReceviedData!.id)
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func SetPostData(_ postData: PostData) {
        ReceviedData = postData
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

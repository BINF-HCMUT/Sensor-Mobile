//
//  TempDiaryViewController.swift
//  IOTProject
//
//  Created by Nguyễn Thái Thanh Bình on 16/03/2023.
//

import UIKit

class TempDiaryViewController: UIViewController, TempManager {
    func updateTempUI(temp: TempModel) {
        DispatchQueue.main.async {
            self.tempDiary.text = temp.data
        }
    }
    
    func catchErrorTemp(error: Error) {
        print(error)
    }
    
    @IBOutlet weak var tempDiary: UITextView!
    let tempDiaryBrain = TempBrain()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tempDiaryBrain.delegate = self
        tempDiaryBrain.getTempLibURL()
        
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
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

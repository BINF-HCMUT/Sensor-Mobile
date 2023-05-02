//
//  HumidDiaryViewController.swift
//  IOTProject
//
//  Created by Nguyễn Thái Thanh Bình on 17/03/2023.
//

import UIKit

class HumidDiaryViewController: UIViewController,HumidManager {
    func updateHumidUI(humid: HumidModel) {
        DispatchQueue.main.async {
            self.humidDiary.text = humid.data
        }
    }
    
    func catchErrorHumid(error: Error) {
        print(error)
    }
    

    

    @IBOutlet weak var humidDiary: UITextView!
    let humidDiaryBrain = HumidBrain()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        humidDiaryBrain.delegate = self
        humidDiaryBrain.getHumidURL()
    }
    

    @IBAction func bachButton(_ sender: UIButton) {
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

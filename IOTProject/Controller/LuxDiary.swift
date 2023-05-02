//
//  LuxDiaryViewController.swift
//  IOTProject
//
//  Created by Nguyễn Thái Thanh Bình on 16/03/2023.
//

import UIKit

class LuxDiaryViewController: UIViewController,LuxManager{
    func updateLuxUI(lux: LuxModel) {
        DispatchQueue.main.async {
            self.luxDiary.text = lux.data
        }
    }
    
    func catchErrorLux(error: Error) {
        print(error)
    }
    

    
    
    @IBOutlet weak var luxDiary: UITextView!
    let luxDiaryBrain = LuxBrain()
    override func viewDidLoad() {
        super.viewDidLoad()
        luxDiaryBrain.delegate = self
        luxDiaryBrain.getLuxURL()
        // Do any additional setup after loading the view.
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

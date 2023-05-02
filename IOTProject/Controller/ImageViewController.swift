//
//  ImageViewController.swift
//  IOTProject
//
//  Created by Nguyễn Thái Thanh Bình on 27/04/2023.
//

import UIKit
import SwiftUI

class ImageViewController: UIViewController {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var aiDetect: UILabel!
    
    var ai = ""
    var base64String : String!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        aiDetect.text = ai
        if let imageData = Data(base64Encoded: base64String), let uiImage = UIImage(data: imageData) {
            // Use the UIImage object to display or save the image
            image.image = uiImage
        }


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

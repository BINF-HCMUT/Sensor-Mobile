//
//  ColorViewController.swift
//  IOTProject
//
//  Created by Nguyễn Thái Thanh Bình on 28/03/2023.
//

import UIKit
import CocoaMQTT

class ColorViewController: UIViewController {
    @IBOutlet weak var redButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var orangeButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var purpleButton: UIButton!
    @IBOutlet weak var indigoButton: UIButton!
    @IBOutlet weak var whiteButton: UIButton!
    
    var message: String = ""
    var mqtt : CocoaMQTT!
    var lightButton : UISwitch!
    let viewManager = ViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        redButton.layer.borderColor = UIColor.blue.cgColor
        blueButton.layer.borderColor = UIColor.systemBlue.cgColor
        yellowButton.layer.borderColor = UIColor.blue.cgColor
        orangeButton.layer.borderColor = UIColor.blue.cgColor
        greenButton.layer.borderColor = UIColor.blue.cgColor
        purpleButton.layer.borderColor = UIColor.blue.cgColor
        indigoButton.layer.borderColor = UIColor.blue.cgColor
        whiteButton.layer.borderColor = UIColor.blue.cgColor
        // Do any additional setup after loading the view.
    }
    
    func resetColor(){
        redButton.layer.borderWidth = 0
        blueButton.layer.borderWidth = 0
        yellowButton.layer.borderWidth = 0
        orangeButton.layer.borderWidth = 0
        greenButton.layer.borderWidth = 0
        purpleButton.layer.borderWidth = 0
        indigoButton.layer.borderWidth = 0
        whiteButton.layer.borderWidth = 0
        
    }
    
    @IBAction func redButton(_ sender: UIButton) {
        resetColor()
        redButton.layer.borderWidth = 5
        message = "red"
    }
    
    @IBAction func blueButton(_ sender: UIButton) {
        resetColor()
        blueButton.layer.borderWidth = 5
        message = "blue"
    }
    
    @IBAction func yellowButton(_ sender: UIButton) {
        resetColor()
        yellowButton.layer.borderWidth = 5
        message = "yellow"
    }
    
    @IBAction func orangeButton(_ sender: UIButton) {
        resetColor()
        orangeButton.layer.borderWidth = 5
        message = "orange"
    }
    
    @IBAction func greenButton(_ sender: UIButton) {
        resetColor()
        greenButton.layer.borderWidth = 5
        message = "green"
    }
    
    @IBAction func purpleButton(_ sender: UIButton) {
        resetColor()
        purpleButton.layer.borderWidth = 5
        message = "purple"
    }
    
    @IBAction func indigoButton(_ sender: UIButton) {
        resetColor()
        indigoButton.layer.borderWidth = 5
        message = "indigo"
    }
    
    @IBAction func whiteButton(_ sender: UIButton) {
        resetColor()
        whiteButton.layer.borderWidth = 5
        message = "white"
    }
    
    @IBAction func turnOnButton(_ sender: UIButton){
        mqtt.publish("HCMUT_IOT/feeds/v10", withString: "1")
        mqtt.publish("HCMUT_IOT/feeds/v11", withString: message)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func backButton(_ sender: UIButton) {
        lightButton.isOn = false
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

//
//  ViewController.swift
//  IOTProject
//
//  Created by Nguyễn Thái Thanh Bình on 08/03/2023.
//

import UIKit
import CocoaMQTT

class ViewController: UIViewController{
    
    @IBOutlet weak var tempSensor: UILabel!
    @IBOutlet weak var luxSensor: UILabel!
    @IBOutlet weak var humidSensor: UILabel!
    @IBOutlet weak var aiDetect: UILabel!
    @IBOutlet weak var speedFanText: UILabel!
    @IBOutlet weak var lightAssistant: UILabel!
    @IBOutlet weak var lightButton: UISwitch!
    @IBOutlet weak var speedfan: UISlider!
    
    
    let topics = ["HCMUT_IOT/feeds/v1","HCMUT_IOT/feeds/v2","HCMUT_IOT/feeds/v3",
                  "HCMUT_IOT/feeds/v10","HCMUT_IOT/feeds/v11","HCMUT_IOT/feeds/v12","HCMUT_IOT/feeds/v14","HCMUT_IOT/feeds/image"]
    var base64String = ""
    var mqttClientManager: CocoaMQTT!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        lightButton.isOn = false
        speedFanText.text = "Speed fan: 28"
        configureMQTTAndConnect()
    }
    

    @IBAction func tempDiary(_ sender: UIButton) {
        self.performSegue(withIdentifier: "gotoTemp", sender: self)
    }
    
    @IBAction func humidDiary(_ sender: UIButton) {
        self.performSegue(withIdentifier: "gotoHumid", sender: self)
    }

    @IBAction func luxDiary(_ sender: UIButton) {
        self.performSegue(withIdentifier: "gotoLux", sender: self)
    }
    

    @IBAction func speedFan(_ sender: UISlider) {
        sender.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        sender.addTarget(self, action: #selector(sliderTouchEnd(_:)), for: [.touchUpInside, .touchUpOutside])
    }

    @objc func sliderValueChanged(_ sender: UISlider) {
        // do nothing
    }

    @objc func sliderTouchEnd(_ sender: UISlider) {
        let value = String(Int(sender.value))
        speedFanText.text = "Speed fan: " + value
        mqttClientManager.publish("HCMUT_IOT/feeds/v12", withString: value)
    }

    @IBAction func lightButton(_ sender: UISwitch) {
        if sender.isOn == true{
            self.performSegue(withIdentifier: "gotoColor", sender: self)
        } else {
            mqttClientManager.publish("HCMUT_IOT/feeds/v10", withString: "0")
            lightAssistant.text = "THE LIGHT IS OFF"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoColor" {
            let vc2 = segue.destination as! ColorViewController
                vc2.mqtt = self.mqttClientManager
                vc2.lightButton = self.lightButton
        }
        if segue.identifier == "gotoImage"{
            let vc2 = segue.destination as! ImageViewController
                vc2.base64String = self.base64String
                vc2.ai = self.aiDetect.text!
        }
    }
    
    @IBAction func imageButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "gotoImage", sender: self)
    }
    
    func updateTemp(value: String){
        tempSensor.text = value
    }
    
    func updateHumid(value: String){
        humidSensor.text = value
    }
    
    func updateLux(value: String){
        luxSensor.text = value
    }
    
    func updateAI(value: String){
        aiDetect.text = value
    }
    
    func updateSpeedFan(value: Int){
        speedfan.value = Float(value)
        speedFanText.text = "Speed fan: " + String(value)
    }
    
    func updateLight(value: String){
        if value == "1"{
            lightButton.isOn = true
            lightAssistant.text = "THE LIGHT IS ON"
        } else{
            lightButton.isOn = false
            lightAssistant.text = "THE LIGHT IS OFF"
        }
    }
    
    func updateLightAssistant(value: String){
        lightAssistant.text = "THE LIGHT IS " + value.uppercased()
    }
    
    func updateImage(value: String){
        base64String = value
    }
}



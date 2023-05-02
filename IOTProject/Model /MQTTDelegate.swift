//
//  MQTTDelegate.swift
//  IOTProject
//
//  Created by Nguyễn Thái Thanh Bình on 16/03/2023.
//

import Foundation
import CocoaMQTT
extension ViewController{
    func configureMQTTAndConnect() {
        let clientID = "HCMUT_IOT-" + String(ProcessInfo().processIdentifier)
        // Replace with the host name for the MQTT Server
        let host = "io.adafruit.com"
        // Replace with the port number for MQTT over TCP (without TLS)
        let port = UInt16(1883)
        mqttClientManager = CocoaMQTT(clientID: clientID, host: host, port: port)
        mqttClientManager.username = "HCMUT_IOT"
        mqttClientManager.password = "aio_DRXz84eTZEZXJWdPq1VFcgmusD9d"
        mqttClientManager.keepAlive = 60
        mqttClientManager.delegate = self
        mqttClientManager.connect()
    }
}
extension ViewController:CocoaMQTTDelegate{
    func mqtt(_ mqtt: CocoaMQTT, didConnectAck ack: CocoaMQTTConnAck) {
        // Connection acknowledged
    
        print("Connection acknowledged \(ack)，rawValue: \(ack.rawValue)")
        if ack == .accept{
            for topic in topics {
                mqttClientManager.subscribe(topic)
            }
        }
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didPublishMessage message: CocoaMQTTMessage, id: UInt16) {
        print("Message published to topic \(message.topic) with payload \(message.string!)")
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didPublishAck id: UInt16) {
        print("Publish acknowledged with id: \(id)")
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didReceiveMessage message: CocoaMQTTMessage, id: UInt16) {
        switch message.topic {
        //update temp
        case "HCMUT_IOT/feeds/v1":
            let value  = message.string! + "°C"
            updateTemp(value: value)
            break
            
        //update humid
        case "HCMUT_IOT/feeds/v2":
            let value = message.string! + "%"
            updateHumid(value: value)
            break
            
        //update lux
        case "HCMUT_IOT/feeds/v3":
            let value = message.string! + "%"
            updateLux(value: value)
            break
        
        //update AI
        case "HCMUT_IOT/feeds/v14":
            let value = message.string!
            updateAI(value: value)
            break
            
        //update speedFan
        case "HCMUT_IOT/feeds/v12":
            let value = Int(message.string!)!
            updateSpeedFan(value: value)
            break
        
        //update Light ON or OFF
        case "HCMUT_IOT/feeds/v10":
            updateLight(value: message.string!)
        break
        
        //update the color of Light
        case "HCMUT_IOT/feeds/v11":
            updateLightAssistant(value: message.string!)
        break
        
        //update image
        case "HCMUT_IOT/feeds/image":
            updateImage(value: message.string!)
        break
        default:
            print("error")
        }
       
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didSubscribeTopics success: NSDictionary, failed: [String]) {
        if success.count > 0 {
            print("Subcribed successfully to topics: \(success.allKeys)")
        }
        if failed.count > 0 {
            print("Failed to subcribe to topics: \(failed)")
        }
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didUnsubscribeTopics topics: [String]) {
        
    }
    
    func mqttDidPing(_ mqtt: CocoaMQTT) {
        
    }
    
    func mqttDidReceivePong(_ mqtt: CocoaMQTT) {
        
    }
    
    func mqttDidDisconnect(_ mqtt: CocoaMQTT, withError err: Error?) {
        print("Disconnected from the MQTT Server with error  \(Error.self)")
    }
}

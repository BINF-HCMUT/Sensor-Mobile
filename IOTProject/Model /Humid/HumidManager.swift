//
//  HumidManager.swift
//  IOTProject
//
//  Created by Nguyễn Thái Thanh Bình on 16/03/2023.
//


import UIKit
protocol HumidManager {
    func updateHumidUI(humid: HumidModel)
    func catchErrorHumid(error: Error)
}
class HumidBrain {

    var delegate: HumidManager?
    var URLString = "https://io.adafruit.com/api/v2/HCMUT_IOT/feeds/v2/data/chart"
    
    func getHumidURL(){
        perform(urlString: URLString)
    }
    
    func perform(urlString : String){
        // Step 1 : Create URL
        if let url = URL(string: urlString){
        
        // Step 2 : Create URL Session
            let session = URLSession(configuration: .default)
        
        // Step 3 : Gice URL Session a task
            let task = session.dataTask(with: url, completionHandler: handle(data: urlResponse: error:) )
            
        // Step 4 : Start the task
            task.resume()
        }
    }
    
    func handle(data: Data?,urlResponse: URLResponse?,error: Error?){
        if error != nil {
            self.delegate?.catchErrorHumid(error: error!)
        }
        
        if let safeData = data {
            if let humidLib = parseJSON(humidLibData: safeData){
                self.delegate?.updateHumidUI(humid: humidLib)
            }
        }
    }
    
    func parseJSON(humidLibData: Data) -> HumidModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(HumidData.self, from: humidLibData)
            var value = decodedData.data
            let count = value.count
            let init_day = value[count-1][0].prefix(10)
            for i in 0...count-1{
                let flag_day = value[count-1-i][0].prefix(10)
                if init_day != flag_day{
                    break
                }
                let str = (value[count-1-i][0].suffix(9)).prefix(8)
                let hour = (Int(str.prefix(2))! + 7)%24
                value[count-1-i][0] = String(hour) + str.suffix(6)
            }
            var decodedString = "Humid_sensor diary:\n"
            for i in 0...count-1{
                if value[count-1-i][0].count > 8{
                    break
                }
                decodedString += "Time: " + value[count-1-i][0].padding(toLength: 15, withPad: " ", startingAt: 0)  + "Value: " + value[count-1-i][1] + "\n"
                
            }
            let humid = HumidModel(data: decodedString)
            return humid
        } catch {
            self.delegate?.catchErrorHumid(error: error)
            return nil
        }
    }
}

//
//  ChartViewController.swift
//  specialTopicSem4
//
//  Created by Anantha Krishna on 04/04/20.
//  Copyright © 2020 Anantha Krishna. All rights reserved.
//

import UIKit
import Charts
import TinyConstraints
import Firebase

class ChartViewController: UIViewController ,ChartViewDelegate{
    lazy var lineChartView: LineChartView = {
        let chartView = LineChartView()
        chartView.backgroundColor = .systemBlue;
        return chartView
    }()
    
    var deviceType:String?
    var counter:Double = 0.0
    
    var ref:DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(lineChartView)
        lineChartView.centerInSuperview()
        lineChartView.width(to: view)
        lineChartView.heightToWidth(of: view)
        ref = Database.database().reference()
        getFirebaseData(ref)
        setData()
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            self.viewDidLoad()
        }
        
        // Do any additional setup after loading the view.
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }
    func setData()
    {
        let set1 = LineChartDataSet(entries: yValues, label: "Value over time")
        let data = LineChartData(dataSet:set1)
        lineChartView.data = data
    }
    
    var yValues:[ChartDataEntry] = []
    
    func getFirebaseData(_ ref:DatabaseReference)
    {
        
        ref.child("Power").observeSingleEvent(of: .value) { (DataSnapshot) in
            
            var rawData:Double?
            rawData = DataSnapshot.value as? Double
            
            if let doubleFromString = rawData
            {
                print(doubleFromString)
                self.yValues.append(ChartDataEntry(x:self.counter,y:doubleFromString))
                self.counter+=1
            }
        }
        
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

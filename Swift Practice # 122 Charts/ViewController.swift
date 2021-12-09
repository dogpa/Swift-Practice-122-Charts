//
//  ViewController.swift
//  Swift Practice # 122 Charts
//
//  Created by Dogpa's MBAir M1 on 2021/12/9.
//

import UIKit
import Charts

class ViewController: UIViewController, ChartViewDelegate {
    
    
    @IBOutlet weak var putChartView: UIView!
    
    //var lineChartView : LineChartView = LineChartView()

    
    
    
     lazy var lineChartView : LineChartView = {
        
        let chartView = LineChartView()
        chartView.backgroundColor = UIColor(red: 100/255, green: 195/255, blue: 200/255, alpha: 0.8)
        chartView.rightAxis.enabled = false  //右邊是否顯示Y軸數值
        
        let leftYAxis = chartView.leftAxis                      //指派leftYAxis取得chartView.leftAxis
        leftYAxis.labelFont = .boldSystemFont(ofSize: 12)       //設定左側Y軸的字體以及大小
        leftYAxis.setLabelCount(5, force: false)                //設定左側Y軸的顯示數值的量force為是否強制設定
        leftYAxis.labelTextColor = .red                         //設定左側Y軸的label顏色
        leftYAxis.axisLineColor = .white                        //顯示左側Y軸的線條顏色
        leftYAxis.axisLineWidth = 2                             //顯示左側Y軸的線條寬度
        leftYAxis.labelPosition = .outsideChart                 //顯示左側Y軸的相對數值的位置(在y軸的內還外)
        
        chartView.xAxis.labelPosition = .bottom
        //chartView.animate(yAxisDuration: 10)                  //Y軸動畫效果
        chartView.animate(xAxisDuration: 1.5)                   //X軸動畫效果
        
        chartView.highlightPerTapEnabled = true                 //是否開啟點選數值後出現的十字線
        
        return chartView
     }()
     
    
    var yOneValueArray : [ChartDataEntry] = []
    var yTwoValueArray : [ChartDataEntry] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        yOneValueArray = creatRandomChartData(randomTimes: Int.random(in: 5...10))
        yTwoValueArray = creatRandomChartDataTwo(randomTimes: Int.random(in: 10...20))
        
        setData()
    }
    
    override func viewDidLayoutSubviews() {
        print(putChartView.frame)
        lineChartView.frame = CGRect(x: 0, y: 0, width: putChartView.frame.height, height: putChartView.frame.height)
        putChartView.addSubview(lineChartView)
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print("目前 \(entry)")
    }

    func setData() {
        

        let set1 = LineChartDataSet(entries: yOneValueArray, label: "隨機數1")
        set1.mode = .horizontalBezier                                           //數值線條樣式直線或曲線
        set1.drawCirclesEnabled = false                                         //數值線條數據的數據值得點是否顯示
        set1.lineWidth = 5                                                      //數值線條的寬度
        set1.setColor(NSUIColor.red)                                            //數值線條的顏色
        set1.fill = Fill(color: .yellow)                                         //線條數值下方的是否填滿的顏色
        set1.fillAlpha = 1                                                      //線條數值下方的Alpha值
        set1.drawFilledEnabled = true                                           //MARK:線條數值下方是否填滿 這條沒設fill相關設定不會顯示
        set1.drawValuesEnabled = false                                          //是否顯示Y軸的值
        set1.drawHorizontalHighlightIndicatorEnabled = false                    //點選數值的十字線的水平是否顯示
        set1.highlightLineWidth = 5                                             //點選數值的十字線的寬度
        set1.highlightColor = .black                                            //點選數值的十字線的顏色

        
        let set2 = LineChartDataSet(entries: yTwoValueArray, label: "隨機數2")
        set2.fill = Fill(color: .green)
        set2.drawFilledEnabled = true
        set2.fillAlpha = 1
        
        
        let data1 = LineChartData(dataSet: set1)
        data1.addDataSet(set2)
        
        //data1.setDrawValues(false)                                              //是否顯示Y軸的值
        lineChartView.data = data1
        
    }
    
    func creatRandomChartData (randomTimes: Int) -> [ChartDataEntry] {
        var array:[ChartDataEntry] = []
        for i in 1...randomTimes {
            let randomCharts = ChartDataEntry(x: Double(i), y: Double.random(in: 1...40))
            //print(i)
            array.append(randomCharts)
        }
        return array
    }
    
    func creatRandomChartDataTwo (randomTimes: Int) -> [ChartDataEntry] {
        var array:[ChartDataEntry] = []
        for i in 1...randomTimes {
            let randomCharts = ChartDataEntry(x: Double(i), y: Double(i+5))
            //print(i)
            array.append(randomCharts)
        }
        return array
    }
    
}


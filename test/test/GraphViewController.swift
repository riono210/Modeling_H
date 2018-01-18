import UIKit
import Charts

class GraphViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        var rect = view.bounds
        rect.origin.x = 220
        rect.origin.y = 0
        rect.size.width -= 450
        rect.size.height -= 700
        
        let x: Double = 10
        
        let chartView = PieChartView(frame: rect)
        let entries = [
            PieChartDataEntry(value: x, label: "A"),
            PieChartDataEntry(value: 20, label: "B"),
            PieChartDataEntry(value: 30, label: "C"),
            PieChartDataEntry(value: 40, label: "D"),
            PieChartDataEntry(value: 50, label: "E")
        ]
        
        let set = PieChartDataSet(values: entries, label: "")
        chartView.data = PieChartData(dataSet: set)
        set.colors = ChartColorTemplates.vordiplom() //グラフの色を設定
        chartView.highlightPerTapEnabled = false  // グラフがタップされたときのハイライトをOFF
        chartView.chartDescription?.enabled = false  // グラフの説明を非表示
        chartView.legend.enabled = false  // グラフの注釈を非表示
        chartView.rotationEnabled = false // グラフがぐるぐる動くのを無効化
        view.addSubview(chartView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

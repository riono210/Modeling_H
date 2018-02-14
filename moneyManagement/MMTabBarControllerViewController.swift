//
//  MMTabBarControllerViewController.swift
//  test
//
//  Created by 山下　耀崇 on 2018/01/31.
//  Copyright © 2018年 松下亮太. All rights reserved.
//

import UIKit

class MMTabBarControllerViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
  
        // アイコンの色
        UITabBar.appearance().tintColor = UIColor(red: 255/255, green: 233/255, blue: 51/255, alpha: 1.0) // yellow
        
        // 背景色
        UITabBar.appearance().barTintColor = UIColor(red: 105/255, green: 105/255, blue: 105/255, alpha: 0.1) // grey black
       
        if #available(iOS 10.0, *) {
            self.tabBar.unselectedItemTintColor = UIColor.white
            self.tabBar.unselectedItemTintColor = UIColor.white
            
        } else {
            // Fallback on earlier versions
        }
        
        
       
        
       
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

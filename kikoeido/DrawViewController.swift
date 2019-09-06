//
//  DrawViewController.swift
//  kikoeido
//
//  Created by 藤崎 達也 on 2019/09/06.
//  Copyright © 2019年 藤崎 達也. All rights reserved.
//

import UIKit

class DrawViewController: UIViewController {
    
    
 
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    

    
    
    @IBAction func toSoundButtonTapped(_ sender: UIButton) {
        
        
        self.performSegue(withIdentifier: "toBackSound", sender: nil)
        
    }
    
 }

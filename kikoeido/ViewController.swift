//
//  ViewController.swift
//  kikoeido
//
//  Created by 藤崎 達也 on 2019/09/06.
//  Copyright © 2019年 藤崎 達也. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var toSoundButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func toSoundTapped(_ sender: UIButton) {
            self.performSegue(withIdentifier: "toSound", sender: nil)
    }
    
    @IBAction func toDrawFromTopButtonTapped(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "toDrawFromTop", sender: nil)
        
    }
    
}


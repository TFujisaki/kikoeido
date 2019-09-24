//
//  ViewController.swift
//  kikoeido
//
//  Created by 藤崎 達也 on 2019/09/06.
//  Copyright © 2019年 藤崎 達也. All rights reserved.
//



// 開発用のメモ。ブランチはTryFixにいる。プロジェクトネームを聴こエイドにしたい。今は聴くエイド。
// kikoeidoプロジェクトファイルは空。開くのは聴くエイドプロジェクトファイル。
// コミットするときに気をつけないと、またプロジェクトが飛んでしまう可能性あり。
// 今はプロジェクトネームを気にせずこのままコミットする。
// ２０１９年９月２５日記

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


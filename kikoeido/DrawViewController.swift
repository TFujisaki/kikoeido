//
//  DrawViewController.swift
//  kikoeido
//
//  Created by 藤崎 達也 on 2019/09/06.
//  Copyright © 2019年 藤崎 達也. All rights reserved.
//

import UIKit

class DrawViewController: UIViewController {
    
     var drawableView: DrawableView! = nil
    
    
    
    
    
    @IBOutlet weak var eraseButton: UIButton!
    
    
    // Constants
    let pointX: Double = 0.0
    let pointY: Double = 80.0
    let bottomMargin = 180

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        drawableView = nil
        
        if drawableView == nil {
            drawableView = DrawableView(frame: CGRect(x: 0.0, y: 120.0, width: self.view.bounds.width, height: self.view.bounds.height - 250))
            
            drawableView.backgroundColor = UIColor.yellow
            self.view.addSubview(drawableView)
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
    

    class DrawableView: UIView {
        
        class Line {
            var points: [CGPoint]
            var color: CGColor
            var width: CGFloat
            
            init(color: CGColor, width: CGFloat) {
                self.color = color
                self.width = width
                self.points = []
            }
            
            func drawOnContext(context: CGContext) {
                UIGraphicsPushContext(context)
                
                context.setStrokeColor(self.color)
                context.setLineWidth(self.width)
                context.setLineCap(CGLineCap.round)
                
                // 2点以上ないと線描画する必要なし
                if self.points.count > 1 {
                    for (index, point) in self.points.enumerated() {
                        if index == 0 {
                            context.move(to: point)
                        } else {
                            context.addLine(to: point)
                        }
                    }
                }
                context.strokePath()
                
                UIGraphicsPopContext()
            }
        }
        
        var lines: [Line] = []
        var currentLine: Line? = nil
        
        // タッチされた
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            let point = touches.first!.location(in: self)
            currentLine = Line(color: UIColor.black.cgColor, width: 5)
            currentLine?.points.append(point)
        }
        
        // タッチが動いた
        override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
            let point = touches.first!.location(in: self)
            currentLine?.points.append(point)
            self.setNeedsDisplay()
        }
        
        // タッチが終わった
        override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
            // 2点以上のlineしか保存する必要なし
            if (currentLine?.points.count)! > 1 {
                lines.append(currentLine!)
            }
            
            currentLine = nil
            self.setNeedsDisplay()
        }
        
        func resetContext(context: CGContext) {
            context.clear(self.bounds)
            if let color = self.backgroundColor {
                color.setFill()
            } else {
                UIColor.white.setFill()
            }
            context.fill(self.bounds)
        }
        
        //描画設定
        override func draw(_ rect: CGRect) {
            let context = UIGraphicsGetCurrentContext()
            
            //画面を一旦初期化
            resetContext(context: context!)
            
            // 描き終わったline
            for line in lines {
                line.drawOnContext(context: context!)
            }
            
            // 描いてる途中のline
            if let line = currentLine {
                line.drawOnContext(context: context!)
            }
        }
    }
    
    
    
    
    

    
    
    @IBAction func toSoundButtonTapped(_ sender: UIButton) {
        
        
        self.performSegue(withIdentifier: "toBackSound", sender: nil)
        
    }
    
    
    @IBAction func eraseButtonTapped(_ sender: UIButton) {
        
        self.viewDidLoad()
    }
    
    
    
    
    
    
    
    
    
    
    
    
 }

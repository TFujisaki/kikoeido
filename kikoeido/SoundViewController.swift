//
//  SoundViewController.swift
//  kikoeido
//
//  Created by 藤崎 達也 on 2019/09/06.
//  Copyright © 2019年 藤崎 達也. All rights reserved.
//

import UIKit
import Speech

class SoundViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var recordButton: UIButton!
    
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ja-JP"))!
    private var recognitionTask: SFSpeechRecognitionTask?
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private let audioEngine = AVAudioEngine()
    
    // String Constants
    let stStartRecording = "録音開始"
    let stStopping = "停止中"
    let stRecognitionComplete = "認識を完了する"
    let stInAction = "(認識中…そのまま話し続けてください)"
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recordButton.isEnabled = false
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
   
    @IBAction func toDrawButtonTapped(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toDraw", sender: nil)
        
        
    }
    
    
    private func startRecording() throws {
        if let recognitionTask = recognitionTask {
            // 既存タスクがあればキャンセルしてリセット
            recognitionTask.cancel()
            self.recognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        
        try audioSession.setCategory(AVAudioSession.Category.playAndRecord, mode: audioSession.mode)
        try audioSession.setMode(AVAudioSession.Mode.measurement)
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        guard let recognitionRequest = recognitionRequest else { fatalError("リクエスト生成エラー") }
        
        recognitionRequest.shouldReportPartialResults = true
        
        // guard let inputNode: AVAudioInputNode = audioEngine.inputNode else { fatalError("InputNodeエラー") }
        let inputNode: AVAudioInputNode = audioEngine.inputNode
        if inputNode == nil {
            fatalError("InputNode Error")
        }
        
        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { (result, error) in
            var isFinal = false
            
            if let result = result {
                self.textView.text = result.bestTranscription.formattedString
                isFinal = result.isFinal
            }
            
            if error != nil || isFinal {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
                
                self.recordButton.isEnabled = true
                self.recordButton.setTitle(self.stStartRecording, for: [])
                self.recordButton.backgroundColor = UIColor.blue
            }
        }
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) {
            (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()   // オーディオエンジン準備
        try audioEngine.start() // オーディオエンジン開始
        
        textView.text = stInAction
    }
    
    
    @IBAction func recordButtonTapped(_ sender: UIButton) {
        
        if audioEngine.isRunning {
            // 音声エンジン動作中なら停止
            audioEngine.stop()
            recognitionRequest?.endAudio()
            recordButton.isEnabled = false
            recordButton.setTitle(stStopping, for: .disabled)
            recordButton.backgroundColor = UIColor.lightGray
            return
        }
        // 録音を開始する
        try! startRecording()
        recordButton.setTitle(stRecognitionComplete, for: [])
        recordButton.backgroundColor = UIColor.red
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        speechRecognizer.delegate = self as? SFSpeechRecognizerDelegate    // デリゲート先になる
        
        SFSpeechRecognizer.requestAuthorization { (status) in
            OperationQueue.main.addOperation {
                switch status {
                case .authorized:   // 許可OK
                    self.recordButton.isEnabled = true
                    self.recordButton.backgroundColor = UIColor.blue
                case .denied:       // 拒否
                    self.recordButton.isEnabled = false
                    self.recordButton.setTitle("録音許可なし", for: .disabled)
                case .restricted:   // 限定
                    self.recordButton.isEnabled = false
                    self.recordButton.setTitle("このデバイスでは無効", for: .disabled)
                case .notDetermined:// 不明
                    self.recordButton.isEnabled = false
                    self.recordButton.setTitle("録音機能が無効", for: .disabled)
                }
            }
        }
    }
    
    public func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available {
            // 利用可能になったら、録音ボタンを有効にする
            recordButton.isEnabled = true
            recordButton.setTitle(stStartRecording, for: [])
            recordButton.backgroundColor = UIColor.blue
        } else {
            // 利用できないなら、録音ボタンは無効にする
            recordButton.isEnabled = false
            recordButton.setTitle("現在、使用不可", for: .disabled)
        }
    }
    
    
    
    
    
    
    

}

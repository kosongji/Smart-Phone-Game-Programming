//
//  SpeechViewController.swift
//  Term-Project
//
//  Created by KPUGAME on 2020/06/14.
//  Copyright © 2020 KPUGAME. All rights reserved.
//

import UIKit
import Speech

class SpeechViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var myTextView: UITextView!

    var url : String = "https://openapi.gg.go.kr/Youngbgactopertinst?KEY=688bb5044d724a149eb7343f27d4681e&SIGUN_CD="
       
    var sigunCD : String = "41820"
    
    @IBAction func doneToSpeechViewController(segue: UIStoryboardSegue)
    {
        
    }
    
       
    // 오디오 메소드
    var audioController : AudioController
       required init?(coder aDecoder: NSCoder) {
           audioController = AudioController()
           audioController.preloadAudioEffects(audioFileNames: AudioEffectFiles)
           
           super.init(coder: aDecoder)
    }
    
    @IBAction func startAction(_ sender: Any) {
        audioController.playerEffect(name: button)
        startButton.isEnabled = false
        stopButton.isEnabled = true
        try! startSession()
    }
    
    @IBAction func stopAction(_ sender: Any) {
         audioController.playerEffect(name: button)
        // 오디오 엔진을 중지하고 다음 세션에 사용할 준비가 된 버튼의 상태를 구성
        if audioEngine.isRunning{
            audioEngine.stop()
            speechRecognitionRequest?.endAudio()
            startButton.isEnabled = true
            stopButton.isEnabled = false
        }
        // 음성인식한 내용을 pickerView에 반영
        if(self.myTextView.text == "가평군"){
            sigunCD = "41820"
        }
        else if(self.myTextView.text == "고양시"){
            sigunCD = "41280"
        }
        else if (self.myTextView.text == "과천시") {
            sigunCD = "41290"
        }else if (self.myTextView.text == "광명시") {
            sigunCD = "41210"  // 광명시
        }else if (self.myTextView.text == "광주시"){
            sigunCD = "41610"  // 광주시
        }else if (self.myTextView.text == "구리시") {
            sigunCD = "41310"  // 구리시
        }else if (self.myTextView.text == "군포시"){
            sigunCD = "41410"  // 군포시
        }else if (self.myTextView.text == "김포시"){
            sigunCD = "41570"
        }else if (self.myTextView.text == "남양주시"){
            sigunCD = "41360"
        }else if (self.myTextView.text == "동두천시"){
            sigunCD = "41250"
        }else if (self.myTextView.text == "부천시") {
            sigunCD = "41190"
        }else if (self.myTextView.text == "성남시") {
            sigunCD = "41130"
        }else if (self.myTextView.text == "수원시") {
            sigunCD = "41110"
        }else if (self.myTextView.text == "시흥시"){
            sigunCD = "41390"
        }else if (self.myTextView.text == "안산시") {
            sigunCD = "41270"
        }else if (self.myTextView.text == "안성시"){
            sigunCD = "41550"
        }else if (self.myTextView.text == "안양시"){
            sigunCD = "41170"
        }else if (self.myTextView.text == "양주시"){
            sigunCD = "41630"
        }else if (self.myTextView.text == "양평군") {
            sigunCD = "41830"
        }else if (self.myTextView.text == "여주시") {
            sigunCD = "41670"
        }else if (self.myTextView.text == "연천군"){
            sigunCD = "41800"
        }else if (self.myTextView.text == "오산시") {
            sigunCD = "41370"
        }else if (self.myTextView.text == "용인시") {
            sigunCD = "41460"
        }else if (self.myTextView.text == "의왕시") {
            sigunCD = "41430"
        }else if (self.myTextView.text == "의정부시") {
            sigunCD = "41150"
        }else if (self.myTextView.text == "이천시"){
            sigunCD = "41500"
        }else if (self.myTextView.text == "파주시") {
            sigunCD = "41480"
        }else if (self.myTextView.text == "평택시") {
            sigunCD = "41220"
        }else if (self.myTextView.text == "포천시"){
            sigunCD = "41650"
        }else if (self.myTextView.text == "하남시"){
            sigunCD = "41450"
        }else if (self.myTextView.text == "화성시"){
           sigunCD = "41590"   // 화성시
        }
    
    }
    
    
    func startSession() throws
    {

        if let recognitionTask = speechRecognitionTask
        {
            recognitionTask.cancel()
            self.speechRecognitionTask = nil
        }

        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(AVAudioSession.Category.record)

        speechRecognitionRequest = SFSpeechAudioBufferRecognitionRequest()

        guard let recognitionRequest = speechRecognitionRequest else { fatalError("SFSpeechAudioBufferRecognitionRequest object creation failed") }

        let inputNode = audioEngine.inputNode //else { fatalError("Audio engine has no input node") }
        recognitionRequest.shouldReportPartialResults = true

        speechRecognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { result, error in

            var finished = false

            if let result = result {
                self.myTextView.text =
                result.bestTranscription.formattedString
                finished = result.isFinal
            }

            if error != nil || finished {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)

                self.speechRecognitionRequest = nil
                self.speechRecognitionTask = nil

                self.startButton.isEnabled = true
            }
        }
        let recordingFormat = inputNode.outputFormat(forBus: 0)
            inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in

                self.speechRecognitionRequest?.append(buffer)
            }

            audioEngine.prepare()
            try audioEngine.start()
    }
    // 음성인식 개체
    // 실시간으로 말하기 기능을 구현하려면 앱에서 SFSpeechRecognizer,
    // SFSpeechAudioBufferRecognitionRequest 및 SFSpeechRecognitionTask 클래스의
    // 인스턴스가 필요합니다.
    
    // 영어 한글 모두 인식하고 싶다면
    //private let speechRecognizer = SFSpeechRecognizer()!
    //영어만 인식하고 싶다면
    //private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))!
    //한글만 인식하고 싶다면
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ko-KR"))!
    private var speechRecognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var speechRecognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    
    //오디오에 필요한 함수
    func authorizeSR()
    {
        SFSpeechRecognizer.requestAuthorization { authStatus in

            OperationQueue.main.addOperation {
                switch authStatus {
               case .authorized:
                   self.startButton.isEnabled = true
                case .denied:
                    self.startButton.isEnabled = false
                    self.startButton.setTitle("Speech recognition access denied by user", for: .disabled)

                case .restricted:
                    self.startButton.isEnabled = false
                    self.startButton.setTitle("Speech recognition restricted on device", for: .disabled)

                case .notDetermined:
                    self.startButton.isEnabled = false
                    self.startButton.setTitle("Speech recognition not authorized", for: .disabled)
            
                @unknown default:
                    print("경고")
                }
            }
        }
    }
    // prepare 메소드
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "segueToSpeechView" {
            if let navController = segue.destination as? UINavigationController {
                if let speechTableViewController = navController.topViewController as?
                    SpeechTableViewController {
                    speechTableViewController.url = url + sigunCD
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        authorizeSR()

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

//
//  SpeechViewController.swift
//  Term-Project
//
//  Created by KPUGAME on 2020/06/14.
//  Copyright © 2020 KPUGAME. All rights reserved.
//

import UIKit
import Speech

class SpeechViewController: UIViewController, XMLParserDelegate, UITableViewDataSource {

    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var myTextView: UITextView!
    
    @IBOutlet weak var tbData: UITableView!
    
    
    //*
    // xml파일을 다운로드 및 파싱하는 프로젝트
    var parser = XMLParser()
    // feed 데이터를 저장하는 mutable array
    var posts = NSMutableArray()
    // title과 data같은 feed 데이터를 저장하는 mutable dictionary
    var elements = NSMutableDictionary()
    var element = NSString()
    // 저장 문자열 변수
    var name = NSMutableString()
    var addr = NSMutableString()
    var sigunCD  = ""
    
    var url : String = "https://openapi.gg.go.kr/Youngbgactopertinst?KEY=688bb5044d724a149eb7343f27d4681e&SIGUN_CD="

    // parse 오브젝트 초기화하고 XMLParserDelegate로 설정하고 XML 파싱시작
    func beginParsing()
    {
        posts = []
        print("실제 url: \(url)")
        parser = XMLParser(contentsOf: (URL(string:url))!)!
        parser.delegate = self
        parser.parse()
        //tbData!.reloadData()
        
    }
    // parser가 새로운 element를 발견하면 변수를 생성한다.
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:])
    {
        element = elementName as NSString
        if (elementName as NSString).isEqual(to: "row")
        {
            elements = NSMutableDictionary()
            elements = [:]
            
            name = NSMutableString()
            name = ""
            addr = NSMutableString()
            addr = ""
        }
    }

    func parser(_ parser: XMLParser, foundCharacters string: String)
    {
        if element.isEqual(to: "INST_NM"){
            name.append(string)
        } else if element.isEqual(to: "REFINE_ROADNM_ADDR"){
            addr.append(string)
        }
       
    }
    // element의 끝에서 feed데이터를 dictionary에 저장
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        if(elementName as NSString).isEqual(to: "row") {
            
            if !name.isEqual(nil) {
                elements.setObject(name, forKey: "INST_NM" as NSCopying)
            }
            if !addr.isEqual(nil) {
                elements.setObject(addr, forKey: "REFINE_ROADNM_ADDR" as NSCopying)
            }
            
            posts.add(elements)
        }
    }
    //row의 개수는 posts 배열 원소의 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return posts.count
    }
    // 테이블뷰 셀의 내용은 title과 subtitle을 posts 배열의 원소에서 title과 date에 해당하는 value로 설정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
           let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

           cell.textLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "INST_NM") as! NSString as String
           cell.detailTextLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "REFINE_ROADNM_ADDR") as! NSString as String

           return cell
    }
    
    // prepare 메소드
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "segueToSpeechView"{
                //url = url + sigunCD
                //print(url)

                beginParsing()
             }
    }
    
    


    @IBAction func startAction(_ sender: Any) {
        startButton.isEnabled = false
        stopButton.isEnabled = true
        try! startSession()
    }
    
    @IBAction func stopAction(_ sender: Any) {
        // 오디오 엔진을 중지하고 다음 세션에 사용할 준비가 된 버튼의 상태를 구성
        if audioEngine.isRunning{
            audioEngine.stop()
            speechRecognitionRequest?.endAudio()
            startButton.isEnabled = true
            stopButton.isEnabled = false
        }
        // 음성인식한 내용을 pickerView에 반영
        if(self.myTextView.text == "가평군")
        {
            sigunCD = "41820"
            url = url + sigunCD
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        authorizeSR()
        
       // beginParsing()
       
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

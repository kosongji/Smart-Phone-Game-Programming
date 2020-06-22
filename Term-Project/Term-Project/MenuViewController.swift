//
//  MenuViewController.swift
//  Term-Project
//
//  Created by KPUGAME on 2020/06/22.
//  Copyright © 2020 KPUGAME. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBAction func buttonAction(_ sender: Any) {
         audioController.playerEffect(name: button)
    }
    @IBAction func buttonAction2(_ sender: Any) {
        audioController.playerEffect(name: button)
    }
    @IBAction func buttonAction3(_ sender: Any) {
        audioController.playerEffect(name: button)
    }
    // 오디오 메소드
    var audioController : AudioController
       required init?(coder aDecoder: NSCoder) {
           audioController = AudioController()
           audioController.preloadAudioEffects(audioFileNames: AudioEffectFiles)
           
           super.init(coder: aDecoder)
    }
    
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

}

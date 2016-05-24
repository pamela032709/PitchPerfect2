//
//  ViewController.swift
//  PitchPerfect1
//
//  Created by POCH on 5/15/16.
//  Copyright © 2016 POCH. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController , AVAudioRecorderDelegate{

    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton:UIButton!
    @IBOutlet weak var stopRecordingButton:UIButton!
    
    var audioRecorder: AVAudioRecorder!
    var recordedAudio : NSURL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //stopRecordingButton.enabled = false
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func recordAudio(sender: AnyObject) {
    print ("record button pressed")
        recordingLabel.text = "Recording in progress"
        //stopRecordingButton.enabled = true
        //recordButton.enabled = false
        

        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,.UserDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        print(filePath)
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
        
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
        }
    
    @IBAction func stopRecording(sender: AnyObject) {
    print("stop Recording Button Pressed")
        //recordButton.enabled = true
        //stopRecordingButton.enabled = false
        recordingLabel.text = "Tap to Record"
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    
    }
    
    override func viewWillAppear(animated: Bool) {
        print("viewWillAppear called")
    }
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        print("AVAudioRecorder finished saving recording")
        if (flag){
            self.performSegueWithIdentifier("stopRecording", sender: audioRecorder.url)
        }else{
            print("Saving of recording failed")
        }
        
        
   }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stopRecording"){
            let playSoundsVC = segue.destinationViewController as!
            PlaySoundsViewController
            let recordedAudioURL = sender as! NSURL
            playSoundsVC.recordedAudio = recordedAudioURL
        }
    }
 
}


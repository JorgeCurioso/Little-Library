//
//  ScanViewController.swift
//  MissysLibrary
//
//  Created by GLR on 5/2/16.
//  Copyright © 2016 GLR. All rights reserved.


import AVFoundation
import UIKit

class ScanViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.blackColor()
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if (captureSession?.running == false) {
            captureSession.startRunning();
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        captureSession = AVCaptureSession()
        
        configureScannerInput()
        configureMetadataOutput()
        setupScanner()
        
        captureSession.startRunning();
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (captureSession?.running == true) {
            captureSession.stopRunning();
        }
    }
    
    
    func configureScannerInput()  {
        let videoCaptureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            failed()
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed();
            return;
        }
    }
    
    
    func configureMetadataOutput()  {
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
            metadataOutput.metadataObjectTypes = metadataOutput.availableMetadataObjectTypes
        } else {
            failed()
            return
        }
    }
    
    func setupScanner() {
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession);
        previewLayer.frame = CGRectMake(0, 50, view.bounds.width, view.bounds.height - 100);
        previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        view.layer.addSublayer(previewLayer);
    }
    
    func failed() {
        presentOKAlert("Scanner failed to load", message: "Do you have your camera enabled?")
    }


    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        
        captureSession.stopRunning()
        
        if let metadataObject = metadataObjects.first {
            
            let readableObject = metadataObject as! AVMetadataMachineReadableCodeObject;
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            let readableObjectToBarcode = readableObject.stringValue
            
            print(readableObjectToBarcode)
            
        }   else    {
            
            failed()
        }
 
 
    }

    
    

}
    



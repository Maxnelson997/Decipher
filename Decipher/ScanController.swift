//
//  ScanController.swift
//  Decipher
//
//  Created by Max Nelson on 10/20/17.
//  Copyright © 2017 cplusplus. All rights reserved.
//

import UIKit
import AVFoundation

class DetailsViewController: UIViewController {
    
    var scannedCode:String?
    var ref:HistoryModel!
    
    @objc func gogo() {
        if ref.isURL {
            (UIApplication.shared.delegate as! AppDelegate).goToURL(url: ref.url)
        } else {
            let alertController = UIAlertController(title: "Bruh..", message: "This is not a valid web URL.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.MNOriginalDarkGray
        print(scannedCode!)
        
        go.addTarget(self, action: #selector(self.gogo), for: .touchUpInside)
        
        
        // Setup label and button layout
        view.addSubview(codeLabel)
        codeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100).isActive = true
        codeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        codeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        codeLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        if let scannedCode = scannedCode {
            codeLabel.text = scannedCode
        }
        
        view.addSubview(scanButton)
        view.addSubview(go)
        
        NSLayoutConstraint.activate([
            
            go.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            go.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            go.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25),
            go.rightAnchor.constraint(lessThanOrEqualTo: scanButton.leftAnchor),
            
            scanButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),
            scanButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            scanButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25),
            scanButton.leftAnchor.constraint(greaterThanOrEqualTo: go.rightAnchor),
            
            ])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let codeLabel:UILabel = {
        let codeLabel = UILabel()
        codeLabel.textAlignment = .center
        codeLabel.textColor = UIColor.MNRed
        codeLabel.backgroundColor = UIColor.MNGray
        codeLabel.layer.cornerRadius = 8
        codeLabel.adjustsFontSizeToFitWidth = true
        codeLabel.font = UIFont.init(customFont: .ProximaNovaLight, withSize: 40)
        codeLabel.layer.masksToBounds = true
        codeLabel.adjustsFontSizeToFitWidth = true
        codeLabel.translatesAutoresizingMaskIntoConstraints = false
        return codeLabel
    }()
    
    lazy var scanButton:UIButton = {
        let scanButton = UIButton(type: .system)
        scanButton.setTitle("Done", for: .normal)
        scanButton.setTitleColor(UIColor.MNBlue, for: .normal)
        scanButton.titleLabel?.adjustsFontSizeToFitWidth = true
        scanButton.titleLabel?.font = UIFont.init(customFont: .ProximaNovaLight, withSize: 40)
        scanButton.backgroundColor = UIColor.MNGray//.orange
        scanButton.layer.cornerRadius = 8
        scanButton.addTarget(self, action: #selector(self.goBackToScan), for: .touchUpInside)
        scanButton.translatesAutoresizingMaskIntoConstraints = false
        return scanButton
    }()
    
    lazy var go:UIButton = {
        let scanButton = UIButton(type: .system)
        scanButton.setTitle("Open", for: .normal)
        scanButton.setTitleColor(UIColor.MNBlue, for: .normal)
        scanButton.titleLabel?.adjustsFontSizeToFitWidth = true
        scanButton.titleLabel?.font = UIFont.init(customFont: .ProximaNovaLight, withSize: 40)
        scanButton.backgroundColor = UIColor.MNGray//.orange
        scanButton.layer.cornerRadius = 8
        scanButton.addTarget(self, action: #selector(self.goBackToScan), for: .touchUpInside)
        scanButton.translatesAutoresizingMaskIntoConstraints = false
        return scanButton
    }()
    
    @objc func goBackToScan() {
        (UIApplication.shared.delegate as! AppDelegate).goBackToScan()
        self.dismiss(animated: true) {
            print("backed")
        }
    }
    
}


class ScanController: DecipherController, AVCaptureMetadataOutputObjectsDelegate {

    var captureDevice:AVCaptureDevice?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var captureSession:AVCaptureSession?
    
    override func viewDidDisappear(_ animated: Bool) {
        captureSession?.stopRunning()
        videoPreviewLayer!.removeFromSuperlayer()
    }
    override func viewDidAppear(_ animated: Bool) {
//        generateCapture()
    }
    override func viewWillAppear(_ animated: Bool) {
        generateCapture()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        generateCapture()
    }
    
    func generateCapture() {
        captureDevice = AVCaptureDevice.default(for: .video)
        // Check if captureDevice returns a value and unwrap it
        if let captureDevice = captureDevice {
            
            do {
                let input = try AVCaptureDeviceInput(device: captureDevice)
                
                captureSession = AVCaptureSession()
                guard let captureSession = captureSession else { return }
                captureSession.addInput(input)
                
                let captureMetadataOutput = AVCaptureMetadataOutput()
                captureSession.addOutput(captureMetadataOutput)
                
                captureMetadataOutput.setMetadataObjectsDelegate(self, queue: .main)
                captureMetadataOutput.metadataObjectTypes = [.code128, .qr, .ean13,  .ean8, .code39] //AVMetadataObject.ObjectType
                
                captureSession.startRunning()
                
                videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                videoPreviewLayer?.videoGravity = .resizeAspectFill
                videoPreviewLayer?.frame = view.layer.bounds
                
                view.layer.addSublayer(videoPreviewLayer!)
                
            } catch {
                print("Error Device Input")
            }
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    let codeFrame:UIView = {
        let codeFrame = UIView()
        codeFrame.layer.borderColor = UIColor.green.cgColor
        codeFrame.layer.borderWidth = 2
        codeFrame.frame = CGRect.zero
        codeFrame.translatesAutoresizingMaskIntoConstraints = false
        return codeFrame
    }()
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects.count == 0 {
            //print("No Input Detected")
            codeFrame.frame = CGRect.zero
            return
        }
        
        let metadataObject = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        guard let stringCodeValue = metadataObject.stringValue else { return }
        
        view.addSubview(codeFrame)
        
        guard let barcodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObject) else { return }
        codeFrame.frame = barcodeObject.bounds
 
        
        // Play system sound with custom mp3 file
        if let customSoundUrl = Bundle.main.url(forResource: "beep-07", withExtension: "mp3") {
            var customSoundId: SystemSoundID = 0
            AudioServicesCreateSystemSoundID(customSoundUrl as CFURL, &customSoundId)
            //let systemSoundId: SystemSoundID = 1016  // to play apple's built in sound, no need for upper 3 lines
            
            AudioServicesAddSystemSoundCompletion(customSoundId, nil, nil, { (customSoundId, _) -> Void in
                AudioServicesDisposeSystemSoundID(customSoundId)
            }, nil)
            
            AudioServicesPlaySystemSound(customSoundId)
        }
        
        // Stop capturing and hence stop executing metadataOutput function over and over again
        captureSession?.stopRunning()
        
        // Call the function which performs navigation and pass the code string value we just detected
        displayDetailsViewController(scannedCode: stringCodeValue)
        
    }
    
    func displayDetailsViewController(scannedCode: String) {
        let deli = (UIApplication.shared.delegate as! AppDelegate)
        let detailsViewController = DetailsViewController()
        detailsViewController.scannedCode = scannedCode
        
        let historyItem = HistoryModel(title: scannedCode)
        detailsViewController.ref = historyItem
        if Model.instance.userSettings.saveScansInHistory {
            Model.instance.scanHistory.append(historyItem)
        } else {
            Model.instance.scanHistory = []
        }
        
        deli.syncScans()
        deli.history.reloadHistory()
        
        //navigationController?.pushViewController(detailsViewController, animated: true)
        present(detailsViewController, animated: true, completion: nil)
    
//        let popView = pop(code:scannedCode)
//        self.view.addSubview(popView)
//        let popHeight = popView.heightAnchor.constraint(equalToConstant: view.frame.width * 0.75)
//        let popWidth = popView.widthAnchor.constraint(equalToConstant: view.frame.width * 0.75)
//
//        NSLayoutConstraint.activate([
//            popView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            popView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            popHeight,
//            popWidth
//
//            ])

//        UIView.animate(withDuration: 0.3) {
//            popHeight.constant = 250
//            popWidth.constant = 150
//            self.view.layoutIfNeeded()
//        }
//        
      
        
    }


}

//class pop:UIStackView {
//    var scannedCode:String?
//
//
//    override init(frame: CGRect) {
//        super.init(frame: .zero)
//        phaseTwo()
//    }
//
//    init(code:String) {
//        super.init(frame:.zero)
//        self.scannedCode = code
//        phaseTwo()
//    }
//
//    required init(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    var container:UIView = {
//       let v = UIView()
//        v.translatesAutoresizingMaskIntoConstraints = false
//        v.backgroundColor = .clear
//        return v
//    }()
//
//    @objc func remove() {
//        UIView.animate(withDuration: 0.3, animations: {
//            self.transform = CGAffineTransform(scaleX: 0, y: 0)
//
//        }) { (true) in
//            self.removeFromSuperview()
//        }
//    }
//
//    var label:DButton = {
//        let b = DButton()
//        b.translatesAutoresizingMaskIntoConstraints = false
//        b.setTitle("ok", for: .normal)
//        b.titleLabel?.textAlignment = .left
//        b.setTitleColor(UIColor.MNBlue, for: .normal)
//        b.titleLabel?.font = UIFont.init(customFont: .ProximaNovaSemibold, withSize: 20)
//        return b
//    }()
//
//    let ok:DButton = {
//        let b = DButton()
//        b.translatesAutoresizingMaskIntoConstraints = false
//        b.setTitle("ok", for: .normal)
//        b.titleLabel?.textAlignment = .left
//        b.setTitleColor(UIColor.MNBlue, for: .normal)
//        b.titleLabel?.font = UIFont.init(customFont: .ProximaNovaSemibold, withSize: 20)
//        return b
//    }()
//
//    let go:DButton = {
//        let b = DButton()
//        b.translatesAutoresizingMaskIntoConstraints = false
//        b.setTitle("go to link", for: .normal)
//        b.titleLabel?.textAlignment = .left
//        b.setTitleColor(UIColor.MNBlue, for: .normal)
//        b.titleLabel?.font = UIFont.init(customFont: .ProximaNovaSemibold, withSize: 20)
//        return b
//    }()
//
//    var stack:UIStackView = {
//       let s = UIStackView()
//        s.translatesAutoresizingMaskIntoConstraints = false
//        s.axis = .horizontal
//        s.distribution = .fill
//        return s
//    }()
//
//    func phaseTwo() {
//
//        if let scannedCode = scannedCode {
//            label.text = scannedCode
//        }
//        self.translatesAutoresizingMaskIntoConstraints = false
//        self.layer.cornerRadius = 8
//        self.backgroundColor = UIColor.MNGreen
//        self.axis = .vertical
//
//        label.isUserInteractionEnabled = false
//
//        container.addSubview(label)
//        self.addArrangedSubview(container)
//        self.addArrangedSubview(stack)
//
//        stack.addArrangedSubview(go)
//        stack.addArrangedSubview(ok)
//
//        NSLayoutConstraint.activate([
//
//            label.centerXAnchor.constraint(equalTo: container.centerXAnchor),
//            label.centerYAnchor.constraint(equalTo: container.centerYAnchor),
//            label.heightAnchor.constraint(equalToConstant: 100),
//            label.leftAnchor.constraint(equalTo: container.leftAnchor),
//            label.rightAnchor.constraint(equalTo: container.rightAnchor),
//
//            container.heightAnchor.constraint(lessThanOrEqualTo: self.heightAnchor),
//            stack.heightAnchor.constraint(equalToConstant: 50)
//            ])
//
////        let deli = UIApplication.shared.delegate as! AppDelegate
////        go.addTarget(deli, action: #selector(), for: <#T##UIControlEvents#>)
//        ok.addTarget(self, action: #selector(self.remove), for: .touchUpInside)
//
//
//    }

//}


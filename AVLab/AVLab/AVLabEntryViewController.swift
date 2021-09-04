//
//  AVLabEntryViewController.swift
//  AVLab
//
//  Created by lobster on 2021/9/4.
//

import UIKit
import MobileCoreServices

class AVLabEntryViewController: AVLabBaseViewController {
    let dataSource = ["视频信息", "视频抽帧", "视频分割", "视频变速", "视频拼接", "调节音量", "视频转场", "画中画", "视频调节"]
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: CGRect(x: 0, y: 0, width: screenW, height: screenH), style: .plain)
        return table
    }()
    
    private lazy var avFilePicker: UIImagePickerController = {
        let avFile = UIImagePickerController()
        return avFile
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addChangeAVLabMaterialEntry()
        showImagePicker()
        showAVLabScene()
        // Do any additional setup after loading the view.
    }
    /*
     @available(iOS, introduced: 3.0, deprecated: 100000)
     public let kUTTypeAudiovisualContent: CFString
     @available(iOS, introduced: 3.0, deprecated: 100000)
     public let kUTTypeMovie: CFString
     @available(iOS, introduced: 3.0, deprecated: 100000)
     public let kUTTypeVideo: CFString
     @available(iOS, introduced: 3.0, deprecated: 100000)
     public let kUTTypeAudio: CFString
     @available(iOS, introduced: 3.0, deprecated: 100000)
     public let kUTTypeQuickTimeMovie: CFString
     @available(iOS, introduced: 3.0, deprecated: 100000)
     public let kUTTypeMPEG: CFString
     @available(iOS, introduced: 8.0, deprecated: 100000)
     public let kUTTypeMPEG2Video: CFString
     @available(iOS, introduced: 8.0, deprecated: 100000)
     public let kUTTypeMPEG2TransportStream: CFString
     @available(iOS, introduced: 3.0, deprecated: 100000)
     public let kUTTypeMP3: CFString
     @available(iOS, introduced: 3.0, deprecated: 100000)
     public let kUTTypeMPEG4: CFString
     @available(iOS, introduced: 3.0, deprecated: 100000)
     public let kUTTypeMPEG4Audio: CFString
     @available(iOS, introduced: 3.0, deprecated: 100000)
     public let kUTTypeAppleProtectedMPEG4Audio: CFString
     @available(iOS, introduced: 8.0, deprecated: 100000)
     public let kUTTypeAppleProtectedMPEG4Video: CFString
     @available(iOS, introduced: 8.0, deprecated: 100000)
     public let kUTTypeAVIMovie: CFString
     @available(iOS, introduced: 8.0, deprecated: 100000)
     public let kUTTypeAudioInterchangeFileFormat: CFString
     @available(iOS, introduced: 8.0, deprecated: 100000)
     public let kUTTypeWaveformAudio: CFString
     @available(iOS, introduced: 8.0, deprecated: 100000)
     public let kUTTypeMIDIAudio: CFString
     */
    
    @objc func showImagePicker() {
        self.avFilePicker.delegate = self
        self.avFilePicker.allowsEditing = false
        self.avFilePicker.mediaTypes = [kUTTypeMovie as String, kUTTypeImage as String, kUTTypeLivePhoto as String]
        self.present(self.avFilePicker, animated: true, completion: nil)
    }
    
    func showAVLabScene() {
        self.title = "AVLab"
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }
    
    func addChangeAVLabMaterialEntry() {
        let rightItem = UIBarButtonItem.init(title: "更换视频", style: .done, target: self, action: #selector(showImagePicker))
        self.navigationItem.rightBarButtonItem = rightItem
    }
    
}

extension AVLabEntryViewController {
    public enum AVExperimentalItem : Int {
        case mediaInfo = 0
    }
}

extension AVLabEntryViewController: UITableViewDelegate, UITableViewDataSource {
    //MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = dataSource[indexPath.row]
        if item == "视频信息" {
            let fileInfoVC = AVLabMediaInfoViewController()
            fileInfoVC.title = item
            self.navigationController?.pushViewController(fileInfoVC, animated: true)
        }
    }
    
    //MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "functionTableViewCellId"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
        }
        cell?.textLabel?.text = dataSource[indexPath.row]
        return cell!
    }
    
}

extension AVLabEntryViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.avFilePicker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        AVLabMediaHandler.shared.prepareAVLabMedia(info: info)
        self.avFilePicker.dismiss(animated: true, completion: nil)
    }
}


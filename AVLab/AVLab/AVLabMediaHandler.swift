//
//  AVLabMediaHandler.swift
//  AVLab
//
//  Created by lobster on 2021/9/4.
//

import UIKit
import AVFoundation
import Photos
import CoreMedia

class AVLabMedia: NSObject {
    var mediaType: String = ""
    var originalImage: UIImage? // a UIImage
    var editedImage: UIImage?   // a UIImage
    var cropRect: NSValue?      // an NSValue (CGRect)
    var mediaURL: URL?          // an NSURL
    var referenceURL: URL?      // an NSURL that references an asset in the AssetsLibrary framework, Will be removed in a future release, use PHPicker.
    var mediaMetadata: Dictionary<String, Any>? // an NSDictionary containing metadata from a captured photo
    var livePhoto: PHLivePhoto? // a PHLivePhoto
    var phAsset: PHAsset?       // a PHAsset, Will be removed in a future release, use PHPicker.
    var imageURL: URL?          // an NSURL
}

class AVLabMediaInfo: NSObject {
    var generalInfo: [Dictionary<String, String>]?
    var videoInfo: [Dictionary<String, String>]?
    var audioInfo: [Dictionary<String, String>]?
}

class AVLabMediaHandler: NSObject {
    static let shared = AVLabMediaHandler()
    var avLabMedia: AVLabMedia? // imagePicker
    var avLabVideoInfo: AVLabMediaInfo? // 详细media数据（参考mediaInfo）
    var avAsset: AVAsset? //
    //MARK: life cycle
    private override init() {
        
    }
    
    override func copy() -> Any {
        return self
    }
    
    override func mutableCopy() -> Any {
        return self
    }
    
    //MARK: methods
    func prepareAVLabMedia(info: [UIImagePickerController.InfoKey: Any]) {
        let media = AVLabMedia()
        media.mediaType = info[.mediaType] as! String
        media.originalImage = info[.originalImage] as? UIImage
        media.editedImage = info[.editedImage] as? UIImage
        media.cropRect = info[.cropRect] as? NSValue
        media.mediaURL = info[.mediaURL] as? URL
        media.referenceURL = info[.referenceURL] as? URL
        media.mediaMetadata = info[.mediaMetadata] as? Dictionary
        media.livePhoto = info[.livePhoto] as? PHLivePhoto
        media.phAsset = info[.phAsset] as? PHAsset
        media.imageURL = info[.imageURL] as? URL
        self.avLabMedia = media
        prepareAVLabMediaInfoSilent()
    }
    
    func prepareAVLabMediaInfoSilent() {
        var generalInfo = [Dictionary<String, String>]()
        var videoInfo = [Dictionary<String, String>]()
        var audioInfo = [Dictionary<String, String>]()
        guard let mediaURL = self.avLabMedia?.mediaURL else {
            return
        }
        avAsset = AVAsset(url: mediaURL)
        guard let avAsset = avAsset else {
            return
        }
        //TODO:异步加载
        avAsset.loadValuesAsynchronously(forKeys: ["c", "tracks", "creationDate", "lyrics", "commonMetadata", "metadata", "availableMetadataFormats", "availableChapterLocales"]) {
            guard let videoTrack = avAsset.tracks(withMediaType: .video).first else {
                return
            }
            let format = videoTrack.formatDescriptions.first
            
            let mediaType = CMFormatDescriptionGetMediaType(format as! CMFormatDescription).toString()
            let codecType = CMFormatDescriptionGetMediaSubType(format as! CMFormatDescription).toString()
            // gernal
            //FIXME:key可能不是String
            for avMetadataItem in avAsset.metadata {
                generalInfo.append([avMetadataItem.key as! String: avMetadataItem.value as! String])
            }
            
            let mediaURLItem = ["资源路径": mediaURL.absoluteString]
            let mediaTypeItem = ["资源类型": mediaType]
            let formatItem = ["格式": codecType]
            let formatProfileItem = ["格式概述": ""]
            let codecIdItem = ["编码ID": ""]
            
            let durationStatus = avAsset.statusOfValue(forKey: "duration", error: nil)
            if durationStatus == .loaded {
                let durationItem = ["时长": avAsset.duration.toString(format: "HH:mm:ss")]
                videoInfo.append(durationItem)
            }
            
            let fileSizeItem = ["大小": ""]
            let bitrateItem = ["比特率": ""]
            let encodeDateItem = ["编码日期": ""]
            let tagDateItem = ["Tag日期": ""]
            let writeLibraryItem = ["编码框架": ""]
            videoInfo.append(mediaURLItem)
            videoInfo.append(mediaTypeItem)
            videoInfo.append(formatItem)
            videoInfo.append(formatProfileItem)
            videoInfo.append(codecIdItem)
            videoInfo.append(fileSizeItem)
            videoInfo.append(bitrateItem)
            videoInfo.append(encodeDateItem)
            videoInfo.append(tagDateItem)
            videoInfo.append(writeLibraryItem)
            
        }
        
    }
    
    func destory() {
        
    }
}

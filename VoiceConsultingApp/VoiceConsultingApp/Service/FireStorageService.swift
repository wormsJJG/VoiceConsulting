//
//  FireStorageService.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/08/07.
//

import Foundation
import UIKit
import RxSwift
import FirebaseStorage

class FireStorageService {
    
    static let shared = FireStorageService()
    private let storageRef = Storage.storage().reference()
    private let profileChild = "avatar"
    private let certificateChild = "introduce"
    private let contentType = "image/jpeg"
    private let metaData = StorageMetadata()
    
    init() {
        
        self.metaData.contentType = contentType
    }
    
    func uploadProfileImage(in image: UIImage?) -> Observable<String> {
        
        return Observable.create { event in
            
            guard let uid = FirebaseAuthManager.shared.getUserUid() else {
                
                event.onError(AuthError.noCurrentUser)
                return Disposables.create()
            }
            
            let avatorRef = self.storageRef.child(uid).child(self.profileChild).child(self.profileChild)
            
            guard let profileImage = image,
                  let imageJpegData = profileImage.jpegData(compressionQuality: 0.1) else {
                
                event.onError(StorageError.nilImage)
                return Disposables.create()
            }
            
            avatorRef
                .putData(imageJpegData, metadata: self.metaData) { data, error in
                    
                    if let error {
                        
                        event.onError(error)
                    } else {
                        
                        avatorRef.downloadURL { url, error in
                            
                            if let error {
                                
                                event.onError(error)
                            }
                            
                            if let url {
                                event.onNext(url.absoluteString)
                                event.onCompleted()
                            } else {
                                
                                event.onError(StorageError.nilUrl)
                            }
                        }
                    }
                }
            return Disposables.create()
        }
    }
    
    func uploadCertificateImages(in images: [UIImage?]) -> Observable<[String]> {
        
        return Observable.create { event in
            
            guard let uid = FirebaseAuthManager.shared.getUserUid() else {
                
                event.onError(AuthError.noCurrentUser)
                return Disposables.create()
            }
            
            var urlList: [String] = []
            
            for image in images {
                
                let certificateRef = self.storageRef.child(uid).child(self.certificateChild).child(String(urlList.count + 1))
                
                guard let profileImage = image,
                      let imageJpegData = profileImage.jpegData(compressionQuality: 0.1) else {
                    
                    event.onError(StorageError.nilImage)
                    return Disposables.create()
                }
                
                certificateRef
                    .putData(imageJpegData, metadata: self.metaData) { data, error in
                        
                        if let error {
                            
                            event.onError(error)
                        } else {
                            
                            certificateRef.downloadURL { url, error in
                                
                                if let error {
                                    
                                    event.onError(error)
                                }
                                
                                if let url {
                                    
                                    urlList.append(url.absoluteString)
                                } else {
                                    
                                    event.onError(StorageError.nilUrl)
                                }
                            }
                        }
                    }
            }
            
            event.onNext(urlList)
            event.onCompleted()
            return Disposables.create()
        }
    }
}

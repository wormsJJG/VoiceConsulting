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
    private let chattingChild = "chatting"
    private let contentType = "image/jpeg"
    private let metaData = StorageMetadata()
    
    init() {
        
        self.metaData.contentType = contentType
    }
    
    private func upLoadImageInFireStorage(in ref: StorageReference,
                                            jpegData: Data,
                                            completion: @escaping((Result<String, Error>) -> Void)) {
        
        ref.putData(jpegData, metadata: self.metaData) { data, error in
                
            if let error {
                    
                completion(.failure(error))
            } else {
                    
                ref.downloadURL { url, error in
                        
                    if let error {
                            
                        completion(.failure(error))
                    }
                        
                    if let url {
                            
                        completion(.success(url.absoluteString))
                    } else {
                            
                        completion(.failure(StorageError.nilUrl))
                    }
                }
            }
        }
    }
    
    func uploadProfileImage(in image: UIImage?) -> Observable<String> {
        
        return Observable.create { event in
            
            if let uid = FirebaseAuthManager.shared.getUserUid() {
                
                let avatorRef = self.storageRef.child(uid).child(self.profileChild).child(self.profileChild)
                
                if let profileImage = image,
                   let imageJpegData = profileImage.jpegData(compressionQuality: 0.1) {
                    
                    self.upLoadImageInFireStorage(in: avatorRef,
                                                  jpegData: imageJpegData,
                                                  completion: { result in
                        
                        switch result {
                            
                        case .success(let urlString):
                            
                            event.onNext(urlString)
                            event.onCompleted()
                        case .failure(let error):
                            
                            event.onError(error)
                        }
                    })
                } else{
                    
                    event.onError(StorageError.nilImage)
                }
            } else {
                
                event.onError(AuthError.noCurrentUser)
            }
            return Disposables.create()
        }
    }
    
    func uploadChattingImage(in image: UIImage?) -> Observable<String> {
        
        return Observable.create { event in
            
            if let uid = FirebaseAuthManager.shared.getUserUid() {
                
                let chattingImageRef = self.storageRef.child(uid).child(self.chattingChild).child(UUID().uuidString)
                
                if let image,
                   let imageJpegData = image.jpegData(compressionQuality: 0.1) {
                    
                    self.upLoadImageInFireStorage(in: chattingImageRef,
                                                  jpegData: imageJpegData,
                                                  completion: { result in
                        
                        switch result {
                            
                        case .success(let urlString):
                            
                            event.onNext(urlString)
                            event.onCompleted()
                        case .failure(let error):
                            
                            event.onError(error)
                        }
                    })
                } else {
                    
                    event.onError(StorageError.nilImage)
                }
            } else {
                
                event.onError(AuthError.noCurrentUser)
            }
            
            return Disposables.create()
        }
    }
    
    func uploadCertificateImage(in image: UIImage?, child: String) -> Observable<String> {
        
        return Observable.create { event in
            
            if let uid = FirebaseAuthManager.shared.getUserUid() {
                
                let certificateRef = self.storageRef.child(uid).child(self.certificateChild).child(child)
                
                if let profileImage = image,
                   let imageJpegData = profileImage.jpegData(compressionQuality: 0.1) {
                    
                    self.upLoadImageInFireStorage(in: certificateRef,
                                                  jpegData: imageJpegData,
                                                  completion: { result in
                        
                        switch result {
                            
                        case .success(let urlString):
                            
                            event.onNext(urlString)
                            event.onCompleted()
                        case .failure(let error):
                            
                            event.onError(error)
                        }
                    })
                } else{
                    
                    event.onError(StorageError.nilImage)
                }
            } else {
                
                event.onError(AuthError.noCurrentUser)
            }
            return Disposables.create()
        }
    }
    
    func uploadCertificateImages(in images: [UIImage?]) -> Observable<[String]> {
        
        return Observable.create { event in
            
            if let uid = FirebaseAuthManager.shared.getUserUid() {
                
                var urlList: [String] = []
                var i = 0
                
                images.forEach { image in
                    i += 1
                    let certificateRef = self.storageRef.child(uid).child(self.certificateChild).child(String(i))
                    
                    if let profileImage = image,
                       let imageJpegData = profileImage.jpegData(compressionQuality: 0.1) {
                        
                        self.upLoadImageInFireStorage(in: certificateRef,
                                                      jpegData: imageJpegData,
                                                      completion: { result in
                            
                            switch result {
                                
                            case .success(let urlString):
                                
                                if i == urlList.count + 1{
                                    
                                    urlList.append(urlString)
                                    event.onNext(urlList)
                                    event.onCompleted()
                                } else {
                                    
                                    urlList.append(urlString)
                                }
                            case .failure(let error):
                                
                                event.onError(error)
                            }
                        })
                    } else {
                        
                        event.onError(StorageError.nilImage)
                    }
                }
            } else {
                
                event.onError(AuthError.noCurrentUser)
            }
            return Disposables.create()
        }
    }
}

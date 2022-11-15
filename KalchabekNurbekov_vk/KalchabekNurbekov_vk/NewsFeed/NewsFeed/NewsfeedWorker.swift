//
//  NewsfeedWorker.swift
//  KalchabekNurbekov_vk
//
//  Created by Kalchabek Nurbekov on 11.11.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

class NewsfeedService {
    
    var networking: Networking
    var fetcher: DataFetcher
    
    private var reveledPostIds = [Int]()
    private var feedResponse: FeedResponse?
    private var newFromInProcess: String?
    
    init() {
        self.networking = NetworkService()
        self.fetcher = NetworkDataFetcher(networking: networking)
    }
    func getUser(completion: @escaping (UserResponse?) -> Void) {
        fetcher.getUser { (userResponse) in
            completion(userResponse)
        }
    }
    func getFeed(completion: @escaping ([Int], FeedResponse) -> Void) {
        fetcher.getFeed(nextBatchFrom: nil) { [ weak self ] (feed) in
            self?.feedResponse = feed
            guard let feedResponse = self?.feedResponse else { return }
            completion(self!.reveledPostIds, feedResponse )
        }
    }
    func revealPostIds(forPostId postId: Int, completion: @escaping ([Int], FeedResponse) -> Void) {
        reveledPostIds.append(postId)
        guard let feedResponse = self.feedResponse else { return }
        completion(reveledPostIds, feedResponse)
    }
    func getNextBatch(completion: @escaping ([Int], FeedResponse) -> Void) {
        newFromInProcess = feedResponse?.nextFrom
        fetcher.getFeed(nextBatchFrom: newFromInProcess) { [ weak self ] (feed) in
            guard let feed = feed else { return }
            guard self?.feedResponse?.nextFrom != feed.nextFrom else { return }
            
            if self?.feedResponse == nil {
                self?.feedResponse = feed
            } else {
                self?.feedResponse?.items.append(contentsOf: feed.items)
                
                var profiles = feed.profiles
                if let oldProfiles = self?.feedResponse?.profiles {
                    let oldProfilesFiltered = oldProfiles.filter { (oldProfile) in
                        !feed.profiles.contains(where: { $0.id == oldProfile.id })
                    }
                    profiles.append(contentsOf: oldProfilesFiltered)
                }
                self?.feedResponse?.profiles = profiles
                
                var groups = feed.groups
                if let oldGroups = self?.feedResponse?.groups {
                    let oldGroupsFiltered = oldGroups.filter { (oldGroup) in
                        !feed.groups.contains(where: { $0.id == oldGroup.id })
                    }
                    groups.append(contentsOf: oldGroupsFiltered)
                }
                self?.feedResponse?.groups = groups
                
                self?.feedResponse?.nextFrom = feed.nextFrom
            }
            
            guard let feedResponse = self?.feedResponse else { return }
            completion(self!.reveledPostIds, feedResponse)
        }
    }
}
  

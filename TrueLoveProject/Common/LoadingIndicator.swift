//
//  LoadingIndicator.swift
//  TrueLoveProject
//
//  Created by Bomi on 2020/5/17.
//  Copyright © 2020 PrototypeC. All rights reserved.
//

import Foundation

import NVActivityIndicatorView

class LoadingIndicator {
    
    var activityData: ActivityData?
    
    init() {
        activityData = ActivityData(type:.ballClipRotatePulse)
        
    }
    
    func start() {
        if activityData == nil {
            activityData = ActivityData()
        }
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData!, nil)
    }
    
    func stop() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
    }
}


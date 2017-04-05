//
//  HeaderDescription.swift
//  FormConstructor
//
//  Created by Alexey Ivankov on 27.03.17.
//  Copyright © 2017 Alexey Ivankov. All rights reserved.
//

import Foundation
import UIKit

public struct HeaderBuildInfo
{
    let buildType:BuildType;
    var title:String?;
    var height:CGFloat?;
    
    public init(buildType:BuildType, title:String? = nil,  height:CGFloat? = nil)
    {
        self.buildType = buildType;
        self.title = title;
        self.height = height;
    }

}

//
//  CellDescription.swift
//  FormConstructor
//
//  Created by Alexey Ivankov on 27.03.17.
//  Copyright © 2017 Alexey Ivankov. All rights reserved.
//

import Foundation
import UIKit

public struct CellBuildInfo
{
    let buildType:BuildType;
    var height:CGFloat?;
    
    public init(buildType:BuildType, height:CGFloat? = nil)
    {
        self.buildType = buildType;
        self.height = height;
    }

}

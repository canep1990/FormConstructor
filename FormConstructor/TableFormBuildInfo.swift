//
//  FormConstructorUIConfigurator.swift
//  FormConstructor
//
//  Created by Alexey Ivankov on 25.03.17.
//  Copyright © 2017 Alexey Ivankov. All rights reserved.
//

import Foundation
import UIKit

public protocol TableFormBuildInfo
{
    func cellBuildInfo(row:Row, section:Section) -> CellBuildInfo
    func footerBuildInfo(section:Section) -> FooterBuildInfo?;
    func headerBuildInfo(section:Section) -> HeaderBuildInfo?;
}



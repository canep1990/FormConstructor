
//  Created by Alexey Ivankov on 29.11.16.
//  Copyright © 2016 Alexey Ivankov. All rights reserved.
//

import Foundation
import UIKit

extension UITableView
{
    func registerCell(reuseId:String, nibName:String)
    {
        let nib = UINib(nibName: nibName, bundle: nil)
        self.register(nib, forCellReuseIdentifier: reuseId);
    }
    
    func registerCell(type:UITableViewCell.Type, reuse_id:String){
        let bundle = Bundle(for: type)
        let fileName = String(describing: type)
        let nib = UINib(nibName: fileName, bundle: bundle)
        
        if bundle.path(forResource: fileName, ofType: "nib") != nil
        {
            self.register(nib, forCellReuseIdentifier: fileName)
        }
        else
        {
            self.register(type, forCellReuseIdentifier: fileName)
        }
    }

    func registerHeaderFooter(reuseId:String, nibName:String)
    {
        let nib = UINib(nibName: nibName, bundle: nil)
        self.register(nib, forHeaderFooterViewReuseIdentifier: reuseId);
    }
    
    func registerHeaderFooter(type:UITableViewHeaderFooterView.Type, reuse_id:String){
        
        let bundle = Bundle(for: type)
        let fileName = String(describing: type)
        let nib = UINib(nibName: fileName, bundle: bundle)
        
        if bundle.path(forResource: fileName, ofType: "nib") != nil
        {
            self.register(nib, forHeaderFooterViewReuseIdentifier: reuse_id)
        }
        else
        {
            self.register(type, forHeaderFooterViewReuseIdentifier: reuse_id)
        }
    }
    
    

    func dequeAndRegisterCell(type:BuildType) -> UITableViewCell?
    {
        var cell:UITableViewCell?;
        
        switch type
        {
        case let .loadFromNib(nib_name, reuse_id):
            cell = self.dequeueReusableCell(withIdentifier: reuse_id);
            
            if cell == nil {
                self.registerCell(reuseId: reuse_id, nibName: nib_name)
            }
            
            cell = self.dequeueReusableCell(withIdentifier: reuse_id);
            
            break;
            
            
        case let .build(type, reuse_id):
            cell = self.dequeueReusableCell(withIdentifier: reuse_id);
            
            if cell == nil && type is UITableViewCell.Type {
                self.registerCell(type: type as! UITableViewCell.Type, reuse_id: reuse_id);
            }
            
            cell = self.dequeueReusableCell(withIdentifier: reuse_id);
            
            break;
        }
        
        return cell;
    }
    
    
    func dequeAndRegisterCell(type:BuildType, indexPath: IndexPath) -> UITableViewCell?
    {
        var cell:UITableViewCell?;
        
        switch type
        {
        case let .loadFromNib(nib_name, reuse_id):
            cell = self.dequeueReusableCell(withIdentifier: reuse_id);
            
            if cell == nil {
                self.registerCell(reuseId: reuse_id, nibName: nib_name)
            }
            
            cell = self.dequeueReusableCell(withIdentifier: reuse_id);
            
            break;
            
            
        case let .build(type, reuse_id):
            cell = self.dequeueReusableCell(withIdentifier: reuse_id);
            
            if cell == nil && type is UITableViewCell.Type {
                self.registerCell(type: type as! UITableViewCell.Type, reuse_id: reuse_id);
            }
            
            cell = self.dequeueReusableCell(withIdentifier: reuse_id, for: indexPath)
            
            break;
        }
        
        return cell;
    }
    
    
    func dequeAndRegisterHeaderFooter(type:BuildType) -> UITableViewHeaderFooterView?
    {
        var header_footer:UITableViewHeaderFooterView?;
        
        switch type
        {
        case let .loadFromNib(nib_name, reuse_id):
            header_footer = self.dequeueReusableHeaderFooterView(withIdentifier: reuse_id);
            
            if header_footer == nil {
                self.registerHeaderFooter(reuseId: reuse_id, nibName: nib_name);
            }
            
            header_footer = self.dequeueReusableHeaderFooterView(withIdentifier: reuse_id);
            
            break;
            
            
        case let .build(type, reuse_id):
             header_footer = self.dequeueReusableHeaderFooterView(withIdentifier: reuse_id);
            
            if header_footer == nil && type is UITableViewHeaderFooterView.Type{
                self.registerHeaderFooter(type: type as! UITableViewHeaderFooterView.Type, reuse_id: reuse_id);
            }
             
             header_footer = self.dequeueReusableHeaderFooterView(withIdentifier: reuse_id);
            
            break;
        }
        
        return header_footer;
    }
}



//
//  ZoomableTableHeaderView.swift
//  ZoomableTableHeader
//
//  Created by Reona Kubo on 2018/09/05.
//  Copyright © 2018年 Reona Kubo. All rights reserved.
//

import UIKit

class ZoomableTableHeaderView: UITableViewHeaderFooterView {

    private var imageView:UIImageView!
    private var label:UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.backgroundView = UIView()
        self.backgroundView?.backgroundColor = UIColor.clear
        
        // imageViewを設置
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = UIColor.clear
        self.contentView.addSubview(imageView)
        
        // ラベルを設置
        label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = UIColor.white
        self.contentView.addSubview(label)
        
    }
    
    func setImage(_ image: UIImage) {
        self.imageView.image = image
    }
    
    func setLabel(_ text: String,frame:CGRect) {
        self.label.frame = frame
        self.label.text = text
    }
    
    func changeFrame(frame:CGRect) {
        self.frame = frame
        self.imageView.frame = frame
    }
    
    func changeFrameMin(frame:CGRect) {
        self.frame = frame
        self.contentView.frame = frame
    }
    
}

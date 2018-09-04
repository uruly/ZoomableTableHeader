//
//  TableView.swift
//  ZoomableTableHeader
//
//  Created by Reona Kubo on 2018/09/05.
//  Copyright © 2018年 Reona Kubo. All rights reserved.
//

import UIKit

class TableView: UITableView {
    
    let cellIdentifier = "cell"
    let headIdentifier = "imageHeader"
    let headerHeight:CGFloat = 240  // headerの高さ

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.delegate = self
        self.dataSource = self
        self.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        self.register(ZoomableTableHeaderView.self, forHeaderFooterViewReuseIdentifier: headIdentifier)
        
    }
    
    convenience init(frame: CGRect) {
        self.init(frame: frame, style: .plain)
    }
}

extension TableView: UITableViewDelegate {
    //ヘッダー
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return headerHeight
        }else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headIdentifier)
        if let header = header as? ZoomableTableHeaderView {
            let labelHeight:CGFloat = 50
            header.changeFrame(frame: CGRect(x:0,y:0,width:self.frame.width,height:headerHeight))
            header.setImage(UIImage(named:"zoomable.png")!)
            header.setLabel("ラベル名",
                          frame: CGRect(x:0,
                                        y:headerHeight - labelHeight,
                                        width:self.frame.width,
                                        height:labelHeight))
        }
        
        return header
    }
}

extension TableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)番目"
        
        return cell
    }
    
}

extension TableView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        guard let header = self.headerView(forSection: 0) as? ZoomableTableHeaderView else {
            return
        }
        
        // iPhoneX用のsafeArea分
        var insetTop:CGFloat = 0
        if #available(iOS 11.0, *) {
            insetTop = scrollView.safeAreaInsets.top
        }
        let labelHeight:CGFloat = 50
        let minSize:CGFloat = headerHeight - labelHeight - insetTop   // スクロール後ヘッダーを固定するサイズ
        let offsetY = scrollView.contentOffset.y + insetTop
        
        // 下に引っ張ると画像が拡大
        if offsetY < 0 {
            let offsetY = offsetY * -1
            let newY = offsetY * -1
            let newHeight = offsetY + self.headerHeight
            header.changeFrame(frame: CGRect(x:0,y:newY,width:header.frame.width,height:newHeight))
        }else if offsetY <= minSize {
            //小さくなる
            let newY = offsetY * -1
            header.changeFrameMin(frame: CGRect(x:0,y:newY,width:header.frame.width,height:header.frame.height))
        }else {
            header.changeFrameMin(frame: CGRect(x:0,y:-minSize,width:header.frame.width,height:header.frame.height))
        }
        
    }
    
}

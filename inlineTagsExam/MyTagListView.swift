//
//  MyTagListView.swift
//  inlineTagsExam
//
//  Created by SBJang on 2021/09/11.
//

import UIKit

class MyTagListView: UICollectionView {
    
    var maxContentsHeight: CGFloat = 0.0 // 펼쳤을때 높이 (== 컨텐츠 높이)
    var isFirstLoaded = false // 처음 컨텐츠 높이를 구했는지
    var completeFirstLoadedBlock: ( ()->Void )?
    
    // 셀이 모두 로드되면 컨텐츠 높이를 갱신
    override func layoutSubviews() {
        super.layoutSubviews()
        // print("MyTagListView.layoutSubviews()", self.contentSize.height)
        if  isFirstLoaded == false {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { // 약간 지연
                print("MyTagListView.layoutSubviews()", self.contentSize.height)
                if self.maxContentsHeight < self.contentSize.height {
                    self.isFirstLoaded = true
                    self.maxContentsHeight = self.contentSize.height
                    if let completed = self.completeFirstLoadedBlock { completed() }
                }
            }
        }
    }

}

//
//  ViewController.swift
//  inlineTagsExam
//
//  Created by SBJang on 2021/09/10.
//

import UIKit
import AlignedCollectionViewFlowLayout

class ViewController: UIViewController {
        
    @IBOutlet weak var myTagListView: MyTagListView!
    @IBOutlet weak var ctrtCollectionViewHeight: NSLayoutConstraint!
    
    let onelineContentsHeight: CGFloat = 48.0 // 접었을때 높이 (한줄)
    
    var acfLayout: AlignedCollectionViewFlowLayout?
    var isCollectionViewFolded = true
    
    let sampleData = ["크레아틴","아르기닌","시트룰린","밀크씨슬","우루사","비타민","루테인","히알루론산","오메가3","카페인", "미네랄","유산균","칼슘","마그네슘","아연"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.myTagListView.dataSource = self
        self.myTagListView.delegate = self
        // 플로우레이아웃 설정
        self.acfLayout = self.myTagListView?.collectionViewLayout as? AlignedCollectionViewFlowLayout
        self.acfLayout?.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        self.acfLayout?.verticalAlignment = .top
        self.acfLayout?.horizontalAlignment = .left
        self.acfLayout?.scrollDirection = .vertical
        // 최초 로딩(높이 계산)이 완료되면
        self.myTagListView.completeFirstLoadedBlock = { () in
            self.acfLayout?.horizontalAlignment = .justified
            self.acfLayout?.scrollDirection = .horizontal
        }
    }

    @IBAction func tapButton(_ sender: Any) {
        self.ctrtCollectionViewHeight.constant = self.isCollectionViewFolded ? self.myTagListView.maxContentsHeight : self.onelineContentsHeight
        self.acfLayout?.horizontalAlignment = self.isCollectionViewFolded ? .left : .justified
        self.acfLayout?.scrollDirection = self.isCollectionViewFolded ? .vertical : .horizontal
        self.isCollectionViewFolded = !self.isCollectionViewFolded
    }
}

//MARK: extension UICollectionViewDataSource, UICollectionViewDelegate, TestCellDelegate
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.sampleData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TestCell", for: indexPath) as! TagCell
        cell.itemIdx = indexPath.row
        cell.lbName.text = "#\(self.sampleData[indexPath.row])"
        return cell
    }

}

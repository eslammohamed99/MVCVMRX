//
//  MainCellSection.swift
//  MVCVMRX
//
//  Created by Mac Srtore Egypt on 22/03/2022.
//

import UIKit
import RxSwift
import RxCocoa

class MainCellSection: UITableViewCell, UIScrollViewDelegate {
    
    @IBOutlet weak var sectionHeight: NSLayoutConstraint!
    @IBOutlet weak var sectionsSliderCV: UICollectionView!
    @IBOutlet weak var sectionTitle: UILabel!
    
    private let bag = DisposeBag()
    let catalogInfo = BehaviorRelay<[catalogData]>(value: [])
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        sectionsSliderCV.rx.setDelegate(self).disposed(by: bag)
        bindTableView()

    }
    
    private func bindTableView() {
        sectionsSliderCV.register(UINib(nibName: itemCellView.identifier, bundle: nil), forCellWithReuseIdentifier: itemCellView.identifier)
        catalogInfo.bind(to: sectionsSliderCV.rx.items(cellIdentifier: itemCellView.identifier, cellType: itemCellView.self)) { (row,item,cell) in
            cell.fillCell(Title: "eslam", Img: "eslam", ShowTitle: true)
            
        }.disposed(by: bag)
    }
    
}
extension MainCellSection: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
}

//
//  MainCellSection.swift
//  MVCVMRX
//
//  Created by Mac Srtore Egypt on 22/03/2022.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

enum viewStyle{
    case linear(Count:Int)
    case grid(Count:Int)
    case slider(Count:Int)
    
}

class MainCellSection: UITableViewCell, UIScrollViewDelegate {
    
    @IBOutlet weak var sectionHeight: NSLayoutConstraint!
    @IBOutlet weak var sectionsSliderCV: UICollectionView!
    @IBOutlet weak var sectionTitle: UILabel!
    
    private let bag = DisposeBag()
    let catalogInfo = BehaviorRelay<[catalogData]>(value: [])
    
    
   // var catalogProperty : BehaviorRelay<viewStyle>?
    let catalogProperty = BehaviorRelay<viewStyle>(value: .linear(Count: 3))
    let flowLayout = UICollectionViewFlowLayout()
    
     var sectionInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        sectionsSliderCV.rx.setDelegate(self).disposed(by: bag)
        sectionsSliderCV.contentInset =  UIEdgeInsets (top: 0, left: 10, bottom: 0, right: 10)
        bindTableView()
        
    }
    
    func cellformat(count:Int, style:UICollectionView.ScrollDirection){
        let marginsAndInsets = sectionInsets.left + sectionInsets.right + sectionsSliderCV.safeAreaInsets.left + sectionsSliderCV.safeAreaInsets.right +  sectionInsets.left * CGFloat(count - 1)
                let itemWidth = ((sectionsSliderCV.bounds.size.width - marginsAndInsets) / CGFloat(count)).rounded(.down)
        
        let size = CGSize(width: itemWidth, height: itemWidth)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        flowLayout.scrollDirection = style
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        sectionsSliderCV.setCollectionViewLayout(flowLayout , animated: true)
    }
    
    private func bindTableView() {
       
        catalogProperty.subscribe { [weak self] result in
            switch result.element{
            case .linear(let count):
                self?.cellformat(count: count, style: .horizontal)
            case .grid(let count):
                print(count)
                self?.cellformat(count: count, style: .vertical)
                self?.sectionsSliderCV.reloadData()
            case .slider(let count):
                print(count)
                self?.cellformat(count: count, style: .vertical)
            default:
                self?.cellformat(count: 4, style: .vertical)
            }
            print(result)
        }
        .disposed(by: bag)
        sectionsSliderCV.register(UINib(nibName: itemCellView.identifier, bundle: nil), forCellWithReuseIdentifier: itemCellView.identifier)
        catalogInfo.bind(to: sectionsSliderCV.rx.items(cellIdentifier: itemCellView.identifier, cellType: itemCellView.self)) { (row,item,cell) in
            cell.itemLBL.text = item.name
            let url = URL(string: item.image ?? "")
            cell.itemIMG?.kf.setImage(with:url)
        }.disposed(by: bag)
        
       
        
        
    }
    
}

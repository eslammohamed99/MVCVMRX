//
//  MainView.swift
//  MVCVMRX
//
//  Created by Mac Srtore Egypt on 22/03/2022.
//

import UIKit
import RxSwift
import RxCocoa
import MOLH
import Localize_Swift

class MainView: UIViewController,UIScrollViewDelegate {
    
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var mainViewSectionsTV: UITableView!
    
    private let bag = DisposeBag()
    private let catalogViewModel = CatalogViewModel()
    private let bannerViewModel = BannerViewModel()
    let flowLayout = UICollectionViewFlowLayout()
    
    private lazy var refreshControl: UIRefreshControl = {
            let refreshControl = UIRefreshControl()
            return refreshControl
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        refreshControl.addTarget(self, action: #selector(refreshControlTriggered), for: .valueChanged)
        
        mainViewSectionsTV.rx.setDelegate(self).disposed(by: bag)
        bannerCollectionView.rx.setDelegate(self).disposed(by: bag)
        
        bannerCollectionView.contentInset =  UIEdgeInsets (top: 0, left: 10, bottom: 0, right: 10)

        mainViewSectionsTV.refreshControl = refreshControl
        bindTableView()
        bindBannerCollectionVieww()
        catalogViewModel.getDataAction.onNext(())
        bannerViewModel.getDataAction.onNext(())
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "عربي".localized(), style: .plain, target: self, action: #selector(changeLanguage))

    }
    @objc func changeLanguage(sender: UIBarButtonItem) {
        Constants.applanuage = "ar"
        
        MOLH.setLanguageTo(MOLHLanguage.currentAppleLanguage() == "en" ? "ar" : "en")
        Constants.applanuage = MOLHLanguage.currentAppleLanguage()
        Localize.setCurrentLanguage(MOLHLanguage.currentAppleLanguage())
        MOLH.reset()
    }
    
    
    private func bindTableView() {
        mainViewSectionsTV.register(UINib(nibName: MainCellSection.identifier, bundle: nil), forCellReuseIdentifier: MainCellSection.identifier)
        catalogViewModel.catalogArray.bind(to: mainViewSectionsTV.rx.items(cellIdentifier: MainCellSection.identifier, cellType: MainCellSection.self)) { (row,item,cell) in
            cell.sectionTitle.text = item.title
            if !(item.show_title ?? false){
                cell.sectionTitle.isHidden = true
            }
            else{
                cell.sectionTitle.isHidden = false
            }
            if item.ui_type == "grid"{
                cell.catalogProperty.accept(.grid(Count: item.row_count ?? 0))
            }
            else if item.ui_type == "slider"{
                cell.catalogProperty.accept(.slider(Count: item.row_count ?? 0))
            }
            else{
                cell.catalogProperty.accept(.linear(Count: item.row_count ?? 0))
               
            }
            cell.catalogInfo.accept(item.data ?? [])
            let height = cell.sectionsSliderCV.collectionViewLayout.collectionViewContentSize.height
            cell.sectionHeight.constant = height 
            
        cell.selectionStyle = .none
    }.disposed(by: bag)
    }
    
//    func cellformat(){
//        let size = CGSize(width: bannerCollectionView.frame.width, height: bannerCollectionView.frame.width)
//        flowLayout.itemSize = CGSize(width: size.width, height: size.height)
//        flowLayout.sectionInset = UIEdgeInsets (top: 0, left: 10, bottom: 0, right:10)
//        flowLayout.scrollDirection = .horizontal
//        flowLayout.minimumLineSpacing = 0
//        flowLayout.minimumInteritemSpacing = 0
//        bannerCollectionView.setCollectionViewLayout(flowLayout , animated: true)
//    }
    
    private func bindBannerCollectionVieww() {
        
        bannerCollectionView.register(UINib(nibName: BannerCell.identifier, bundle: nil), forCellWithReuseIdentifier: BannerCell.identifier)
        bannerViewModel.bannerArray.bind(to: bannerCollectionView.rx.items(cellIdentifier: BannerCell.identifier, cellType: BannerCell.self)) { (row,item,cell) in
            let url = URL(string: item.image ?? "")
            cell.bannerIMG?.kf.setImage(with:url)
            cell.bannerView.layer.cornerRadius = 20
            cell.bannerView.clipsToBounds = true

    }.disposed(by: bag)
    }
    
}
extension MainView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
extension MainView:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: bannerCollectionView.frame.width-20, height: bannerCollectionView.frame.width)
        return CGSize(width: size.width, height: size.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

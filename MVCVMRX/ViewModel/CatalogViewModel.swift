//
//  CatalogViewModel.swift
//  MVCVMRX
//
//  Created by Mac Srtore Egypt on 21/03/2022.
//

import UIKit
import RxSwift
import RxCocoa

class CatalogViewModel {
    
    private let disposeBag = DisposeBag()
    let catalogArray = BehaviorRelay<[CatalogResult]>(value: [])
//    let refreshControlAction = PublishSubject<Void>()
//    let refreshControlCompelted = PublishSubject<Void>()
//    private var isRefreshRequstStillResume = false

//    init() {
//           bannerControllerRefreshbind()
//       }
    
//    private func bannerControllerRefreshbind() {
//
//           refreshControlAction.subscribe { [weak self] _ in
//               self?.refreshControlTriggered()
//           }
//           .disposed(by: disposeBag)
//       }
    
    private func refreshControlTriggered() {
        catalogArray.accept([])
        fetchBannerData(isRefreshControl: true)
    }
    
    private func fetchBannerData(isRefreshControl: Bool) {
//        if isRefreshRequstStillResume { return }
//        self.isRefreshRequstStillResume = isRefreshControl
        
        fetchBannerList() { Result,Error  in
            if let res = Result{
            self.catalogArray.accept(res)
//            self.isRefreshRequstStillResume = false
//            self.refreshControlCompelted.onNext(())
            }
            else{
                // show error toast
            }
        }
           
       }
    
    private func fetchBannerList(completion: @escaping ([CatalogResult]?,String?) -> ()) {
        APIClient.getCatalogData().observe(on: MainScheduler.instance)
            .subscribe(onNext: { catalogList in
                
                if let catalogs = catalogList.catalogResult{
                    completion(catalogs, nil)
                    }
                else{
                    completion(nil, "Data Error")
                }
            }, onError: { error in
                switch error {
                case ApiError.conflict:
                    print("Conflict error")
                case ApiError.forbidden:
                    completion(nil, "Url invalid")
                    print("Forbidden error")
                case ApiError.notFound:
                    completion(nil, "No data Found")
                default:
                    completion(nil, "Unknown error:\(error)")
                    print("Unknown error:", error)
                }
            })
            .disposed(by: disposeBag)
    
    }

}

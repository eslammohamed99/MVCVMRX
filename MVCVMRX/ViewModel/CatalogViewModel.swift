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
    let getDataAction = PublishSubject<Void>()
    let refreshControlAction = PublishSubject<Void>()
//    let refreshControlCompelted = PublishSubject<Void>()
//    private var isRefreshRequstStillResume = false

    init() {
           bannerControllerRefreshbind()
       }
    
    private func bannerControllerRefreshbind() {
        
        getDataAction.subscribe { [weak self] _ in
            self?.fetchCatalogData(isRefreshControl: false)
        }
        .disposed(by: disposeBag)

           refreshControlAction.subscribe { [weak self] _ in
               self?.refreshControlTriggered()
           }
           .disposed(by: disposeBag)
       }
    
    private func refreshControlTriggered() {
        catalogArray.accept([])
        fetchCatalogData(isRefreshControl: true)
    }
    
    private func fetchCatalogData(isRefreshControl: Bool) {
//        if isRefreshRequstStillResume { return }
//        self.isRefreshRequstStillResume = isRefreshControl
        
        fetchCatalogList() { Result,Error  in
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
    
    private func fetchCatalogList(completion: @escaping ([CatalogResult]?,String?) -> ()) {
        ProgressLoaderHUD.showLoader()
        APIClient.getCatalogData().observe(on: MainScheduler.instance)
            .subscribe(onNext: { catalogList in
                ProgressLoaderHUD.hideLoader()
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

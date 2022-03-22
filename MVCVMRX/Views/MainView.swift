//
//  MainView.swift
//  MVCVMRX
//
//  Created by Mac Srtore Egypt on 22/03/2022.
//

import UIKit
import RxSwift
import RxCocoa

class MainView: UIViewController,UIScrollViewDelegate {
    
    @IBOutlet weak var mainViewSectionsTV: UITableView!
    
    private let bag = DisposeBag()
    private let viewModel = CatalogViewModel()
    
    private lazy var refreshControl: UIRefreshControl = {
            let refreshControl = UIRefreshControl()
            return refreshControl
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        refreshControl.addTarget(self, action: #selector(refreshControlTriggered), for: .valueChanged)
        
        mainViewSectionsTV.rx.setDelegate(self).disposed(by: bag)
        mainViewSectionsTV.refreshControl = refreshControl
        bindTableView()
        viewModel.getDataAction.onNext(())
    }
    
    private func bindTableView() {
//    viewModel.refreshControlCompelted.subscribe { [weak self] _ in
//        guard let self = self else { return }
//        self.refreshControl.endRefreshing()
//    }
//    .disposed(by: bag)
    
    
        mainViewSectionsTV.register(UINib(nibName: MainCellSection.identifier, bundle: nil), forCellReuseIdentifier: MainCellSection.identifier)
        viewModel.catalogArray.bind(to: mainViewSectionsTV.rx.items(cellIdentifier: MainCellSection.identifier, cellType: MainCellSection.self)) { (row,item,cell) in
          //  cell.fillCell(itemInfo: item)
            cell.catalogInfo.accept(item.data ?? [])
        cell.selectionStyle = .none
    }.disposed(by: bag)
    }
    
}
extension MainView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

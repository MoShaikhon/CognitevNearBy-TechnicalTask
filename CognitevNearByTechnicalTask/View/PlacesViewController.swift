//
//  ViewController.swift
//  CognitevNearByTechnicalTask
//
//  Created by Mohamed Shaikhon on 12/23/19.
//  Copyright © 2019 Mohamed Shaikhon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
//move to constants
let placeCellID = "placeCell"

class PlacesViewController: UIViewController {
    private var placesViewModel: PlacesViewModellable
    private var placesTableView: PlacesTableView?
    private var placesDataSource: [PresentingCellDataSource]?
    
    var bag = DisposeBag()
    init(placesViewModel: PlacesViewModellable) {
        self.placesViewModel = placesViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        placesViewModel.getDataSource(locatioUpdateFrequency: .continuous).bind(to: self.placesTableView!.rx.items(cellIdentifier: placeCellID,cellType: PlaceCell.self)) { index, model, cell in
            var modelWithPhoto = model
//            cell.populateCell(with: model)
//                        self.placesViewModel.getPhotoURL(forVenueID: model.id).subscribe(onNext: {url in
//                            modelWithPhoto.placePhoto = url
//                            print(modelWithPhoto.placePhoto)
//                            cell.populateCell(with: modelWithPhoto)
//            
//                        },onCompleted: {
//                            print("hi")
//                        }).disposed(by: self.bag)
                        
        }
        .disposed(by: bag)
        //        self.placesTableView?.rx.modelSelected(PresentingCellDataSource.self).subscribe()
        placesTableView?.rx.willDisplayCell
            .subscribe(onNext: ({ (cell,indexPath) in
                cell.alpha = 0
                let transform = CATransform3DTranslate(CATransform3DIdentity, -250, 0, 0)
                cell.layer.transform = transform
                UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                    cell.alpha = 1
                    cell.layer.transform = CATransform3DIdentity
                }, completion: nil)
            })).disposed(by: bag)
        
    }
    fileprivate func setupNavBarItems() {
        let realTimeButton = UIBarButtonItem(title: "RealTime", style: .plain, target: self, action: #selector(didTapRealTimeUpdatesButton))
        let nearByButton =  UIButton(type: .custom)
        nearByButton.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        nearByButton.setTitle("Near By", for: .normal)
        nearByButton.setTitleColor(.black, for: .normal)
        nearByButton.addTarget(self, action: #selector(didTapNearByButton), for: .touchUpInside)
        self.navigationItem.titleView = nearByButton
        
        self.navigationItem.rightBarButtonItem  = realTimeButton
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        placesTableView = PlacesTableView(frame: view.frame)
        placesTableView?.frame = view.frame
        view.addSubview(placesTableView!)
        setupNavBarItems()
    }
    
    @objc func didTapRealTimeUpdatesButton() {
        placesTableView?.delegate = nil
        placesTableView?.dataSource = nil
        
        placesViewModel.getDataSource(locatioUpdateFrequency: .continuous).bind(to: self.placesTableView!.rx.items(cellIdentifier: placeCellID,cellType: PlaceCell.self)) { index, model, cell in
            var modelWithPhoto = model
            cell.populateCell(with: model)
            //            self.placesViewModel.getPhotoURL(forVenueID: model.id).subscribe(onNext: {url in
            //                modelWithPhoto.placePhoto = url
            //                print(modelWithPhoto.placePhoto)
            //                cell.populateCell(with: modelWithPhoto)
            //
            //            },onCompleted: {
            //                print("hi")
            //            }).disposed(by: self.bag)
            //            placesViewModel.getPhotoURL()
            //          cell.textLabel?.text = model
        }
        .disposed(by: bag)
        //        self.placesTableView?.rx.modelSelected(PresentingCellDataSource.self).subscribe()
        placesTableView?.rx.willDisplayCell
            .subscribe(onNext: ({ (cell,indexPath) in
                cell.alpha = 0
                let transform = CATransform3DTranslate(CATransform3DIdentity, -250, 0, 0)
                cell.layer.transform = transform
                UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                    cell.alpha = 1
                    cell.layer.transform = CATransform3DIdentity
                }, completion: nil)
            })).disposed(by: bag)
    }
    @objc func didTapNearByButton() {
        placesTableView?.delegate = nil
        placesTableView?.dataSource = nil
        let x = placesViewModel.getDataSource(locatioUpdateFrequency: .once).asObservable()
        x.bind(to: self.placesTableView!.rx.items(cellIdentifier: placeCellID,cellType: PlaceCell.self)) { index, model, cell in
            var modelWithPhoto = model
            cell.populateCell(with: model)
            //            self.placesViewModel.getPhotoURL(forVenueID: model.id).subscribe(onNext: {url in
            //                modelWithPhoto.placePhoto = url
            //                print(modelWithPhoto.placePhoto)
            //                cell.populateCell(with: modelWithPhoto)
            //
            //            },onCompleted: {
            //                print("hi")
            //            }).disposed(by: self.bag)
            //            placesViewModel.getPhotoURL()
            //          cell.textLabel?.text = model
            }
        .disposed(by: bag)
        
        //        self.placesTableView?.rx.modelSelected(PresentingCellDataSource.self).subscribe()
        placesTableView?.rx.willDisplayCell
            .subscribe(onNext: ({ (cell,indexPath) in
                cell.alpha = 0
                let transform = CATransform3DTranslate(CATransform3DIdentity, -250, 0, 0)
                cell.layer.transform = transform
                UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                    cell.alpha = 1
                    cell.layer.transform = CATransform3DIdentity
                }, completion: nil)
            })).disposed(by: bag)
    }
}
class PlacesTableView: UITableView {
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        register(PlaceCell.self, forCellReuseIdentifier: placeCellID)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

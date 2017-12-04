//
//  ImageOutputCollectionViewController.swift
//  APPdentify
//
//  Created by Michael Castillo on 10/9/17.
//  Copyright © 2017 Michael Castillo. All rights reserved.
//

import UIKit
import CoreLocation


class ImageOutputCollectionViewController: UICollectionViewController {
    

    // MARK: - Life Cycle

    var core = App.sharedCore
    var imageOutputs = [ImageOutput]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ImageOutputCollectionViewCell.className)
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        core.add(subscriber: self)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        core.remove(subscriber: self)
    }

@IBAction func addButtonTapped(_ sender: Any) {
        ImagePickerManager.shared.presentPickerAlert(on: self)
    }
    
}

extension ImageOutputCollectionViewController: Subscriber {
    
    func update(with state: AppState) {
        imageOutputs = state.imageOutputs
    }
    
}

// MARK: UICollectionViewDataSource

extension ImageOutputCollectionViewController {
    
    enum Section: Int {
        case create
        case history
        
        static let allValues = [Section.create, .history]
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Section.allValues.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let theSection = Section(rawValue: section) else { return 0 }
        switch theSection {
        case .create:
            return 1
        case .history:
            return imageOutputs.count
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let theSection = Section(rawValue: indexPath.section)!
        switch theSection {
        case .create:
            // TODO: - setup storyboard and pass in reuse ID
                        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CreationCell", for: indexPath)
            return cell
        case .history:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageOutputCollectionViewCell.className, for: indexPath) as! ImageOutputCollectionViewCell
            cell.update(with: imageOutputs[indexPath.item])
            return cell
        }
    }
    
}

// MARK: - Fileprivate


extension ImageOutputCollectionViewController {

        // TODO: - setup collectionView behavior such as speed, direction, and type of collectionview
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedSection = Section(rawValue: indexPath.section)!
        switch selectedSection {
        case .create:
            ImagePickerManager.shared.presentPickerAlert(on: self)
        case .history:
            break
        }
        
    }
    
}


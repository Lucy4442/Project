//
//  CellEnum.swift
//  Helpy
//
//  Created by mac on 12/12/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

enum CellName : String {
    //MARK: ==========TableView Cell==========
    //MARK: ==Menu==
    case MenuTableViewCell = "MenuTableViewCell"
    case MenuLogoutButtonCell = "MenuLogoutButtonCell"
    case GeneralCell = "GeneralCell"
    case MenuoptionTableCell = "MenuoptionTableCell"
    case UserMenuTableViewCell = "UserMenuTableViewCell"
    
    //MARK: ==Service==
    case ServiceCategoriesCell = "ServiceCategoriesCell"
    case RecentlyAddedTableViewCell = "RecentlyAddedTableViewCell"
    case BannerTableViewCell = "BannerTableViewCell"
    case CleaningJobTableViewCell = "CleaningJobTableViewCell"
    
    //MARK: ==========Collectionview Cell==========
    //MARK: ==Menu==
    case MenuCollectionViewCell = "MenuCollectionViewCell"
    
    //MARK: ==Service==
    case ServiceCollectionViewCell = "ServiceCollectionViewCell"
    case ServiceDocumentCollectionViewCell = "ServiceDocumentCollectionViewCell"
    case CleaningJobCollectionViewCell = "CleaningJobCollectionViewCell"
}

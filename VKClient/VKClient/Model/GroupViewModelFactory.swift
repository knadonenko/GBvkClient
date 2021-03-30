//
//  GroupViewModelFactory.swift
//  VKClient
//
//  Created by Константин Надоненко on 30.03.2021.
//

import Foundation

class GroupViewModelFactory {
    
    func constructViewModels(from groups: [GroupModel]) -> [GroupViewModel] {
        return groups.compactMap(self.viewModel)
    }
    
    private func viewModel(from group: GroupModel) -> GroupViewModel {
        
        let id = group.id 
        let photoLink = group.photo_50 ?? ""
        let groupName = group.name ?? ""
        
        return GroupViewModel(id: id, name: groupName, photo_50: photoLink)
        
    }
    
}

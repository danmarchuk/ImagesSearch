//
//  SearchResultsViewController.swift
//  ImagesSearch
//
//  Created by Данік on 26/05/2023.
//

import Foundation
import UIKit
import SDWebImage

class SearchResultsViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    let imagesArr = ["https://pixabay.com/get/g279e8bd5250af3336aa70ca2390d777558fd4c4f881466ee9a0e18d099f4d774ecd938c5843fb35ad3d7730c6d69765d9e68ae9335bd2e3fe07a706acfc4c51d_640.jpg", "https://pixabay.com/get/g9bd8ad5ee4bbb387930ace43e57dcc3138025d514ee0832e3db8ca8f19ce94c7fdee7aa0635d19d87387d400a7d9fd1f710aaa211b443ccf23931c26db07d61d_640.jpg", "https://pixabay.com/get/g86ebca77a1322a063bd048a9543e22541f8e42286c22f92c56770dce08c3c51ae0607aacbe947cbc2cfbe031c3fe3a6026997ce94c046f034a7c7d84a9a6dd10_640.jpg", "https://pixabay.com/get/gd86b9da73fd57c5aab9a093bbc2eb4efcee8f14f3dfa96569853138b4c4279d6e4ad7be25ceca80e46a829b446d57aeb_640.jpg", "https://pixabay.com/get/gb528ff73b6f94e48a48e8e4461a7fe2ee79ecfb4affda212a3b52f5484cfc102303d892f9223cad24367947e0edb995792cd4b6bace679d3f49c6dcce9a7dfb1_640.jpg", "https://pixabay.com/get/gdd1d95501c2224e5b264035c5a237f485a21d15a61c7576c62b3d970fca6aa8387e6654ff46be575d84d9155a3565806c19ed539c9481385b3929267c11f8792_640.jpg", "https://pixabay.com/get/gbdc5624c3d0e03bd45941b00d93ff680a461e192f8096cecfad65d86d674f3dadf55ded29ad371fa3ebdb9aef97cd255702af05e35459514553d20d3a5c4dde3_640.jpg", "https://pixabay.com/get/g720c81ae5f70ad8ed233587aaf614a9564a7821c4cfd1d288994ad45e39fceaac864226463d9456dc311e620aad4572a_640.jpg", "https://pixabay.com/get/gd8ed6a022c6815834cd2838c9c652c23925dd8e766fdd443858df6d1975f9dbc213a62058558e387e360e3eb5349c1adfc8ef58fe2508ff84397cb3d7f7c36bc_640.jpg", "https://pixabay.com/get/gdf9d528acbebe0fb0cbacdf6ed74f6c309e853b2f295dd46e2c6da777e1ac5075fee212466cf058875bdd382c31ad449aeada925362dcc44dfd35c35850e8571_640.jpg", "https://pixabay.com/get/g8c017cf65cbc3f5923f833fa83d12125401a96ce8542b42bcc6e24c20e0fa108d4492bff296902a7b8df828bfc282778b8a2b66a7f31c5b47838324605c97d5c_640.jpg", "https://pixabay.com/get/g6eb25acbb64aec7e0f2e4e9a4ed3fa5cec308f96af8097d46d1845249d6091b0e3430e0d6a63df64072964205adcd9a74c013361d1944b8586bd7325568e107c_640.jpg", "https://pixabay.com/get/g46e1f5c34918a26606293edc56c7f680ab379e48b1c217f6e9d83437c2ad1e5acd1b25c378efc45c3966c0a8379edae9_640.jpg", "https://pixabay.com/get/gbee1354af8edeee3ceafab7c1d263e2fb41bb1ce73211b808199e54c0e6cc98ed999ab43d34d3042c6dc6f41549dfa973078cedd76f5ace936dcd03f1c63ae49_640.jpg", "https://pixabay.com/get/gbfd522a233573630f359873e01a3b721a9e6ac7003073cab68bc4e96faadb4d28e14afc47f6d5cfdff5b868f437fd5d973de7b852f09ff32d64b28cfc33c6069_640.jpg", "https://pixabay.com/get/g85a82036408ab42db7548f65f3b7a8299a54731432a22a8e9b9443d18119fc476a17c8695fb9248fdfa1d4c07b92b26ad8b1b9ab4e7abdd9779964c00a7582da_640.jpg", "https://pixabay.com/get/g1b5459de776c5a3bc4c88670e3b911402381969bc7f3bebd95feb13006c96f6b8e93401f85d7e97d57a8882e890b2bcb_640.jpg", "https://pixabay.com/get/g36e414e503724434b64e41ae14027d649f2b2cdc47799dbbfa976c1880a33538b52ada7213233a9f83f185455b26a9ce7d8a8bf269d775991305a0afe8b04fb5_640.jpg", "https://pixabay.com/get/g93df8906d4f3c770f1ba0dfeec214dfb66b44e98106fa38863c98925b15f5f46a935b171536dae0d9ba4f6d2acce29e28b1efbe78b0804654af07cfc6a32c86e_640.jpg", "https://pixabay.com/get/g16e59a3d2fa2e39ae96bc90c65033b7d458c1ccc1090a972550c26a841040c34a23de78ff671293a378e6e2e7313ac4f39d5199bf63f36fcb94e03f5422fc96b_640.jpg"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "CustomImageCell", bundle: nil)
            collectionView.register(nib, forCellWithReuseIdentifier: CustomImageCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
}

extension SearchResultsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imagesArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomImageCell.identifier, for: indexPath) as? CustomImageCell else {
            fatalError("Could not dequeue CustomImageCell")
        }

        let imageURL = imagesArr[indexPath.row]
        cell.imageView?.sd_setImage(with: URL(string: imageURL), completed: nil)
        return cell
    }

    
    
}

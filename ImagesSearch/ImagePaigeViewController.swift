//
//  ImagePaigeViewController.swift
//  ImagesSearch
//
//  Created by Данік on 30/05/2023.
//

import Foundation
import UIKit
import SDWebImage

class ImagePaigeViewController: UIViewController {
    var imagesArr: [String] = ["https://pixabay.com/get/g56fd9ba30c2593307e896cb60606b808bdf1445dde82425310d5f018cf6f0c6b2a8fad40649d6e996ec9b8adb514ab8eeb13ebdcce37e5d87143725dfea64fc9_640.jpg", "https://pixabay.com/get/gcf64ff5fbc85443757c3db04b214d68fb96a1148d10bc25e06399e8c350068aba2884079418ee44a73b2914a3313d84b1f397d13eb72a3dad790bbc2df3a0344_640.jpg", "https://pixabay.com/get/g15b7e399f5094c00861d9615e6a85e233b4ea786126f643cae5297ad5497a5d1a3aeec8494a6f98e63143e9905ab4bf36a069903e1d9d03fb36bacc4cfb61398_640.jpg", "https://pixabay.com/get/g4aa4d8771fa8f5e343c61dcbac35d587c639ebdc8e4246f7bf8a2e3a1a6aa5ca37247c4dc3bfcf95c6369c2990036ef5f99919bbebde9a60887743ea5075f7e9_640.jpg", "https://pixabay.com/get/g99f4dec33f9c6204cf5f26b56421ca9e61b4859de215c64bea3aeb717bc6b2a4c289ddfde3122341973a76e28b9bfd83cec804ac53fc9501df6ebb609ae1211e_640.jpg", "https://pixabay.com/get/gc6135993b3eba90919a42db9f544ce3bca744af02ab51b2dccba22018fc171c8ae9e7718276482d807eaa305d6ab8ad3efa6e5ab77a60025521d3c8fb77dd56f_640.jpg", "https://pixabay.com/get/g545a286513c751a30fa7f4937fb7475f52bbae9644e26ebac7e4c4dd63b9d97c582be6c0426513b97ce616a0d036b695131cc7c70a3a87afcfb5c1022ecadb44_640.jpg", "https://pixabay.com/get/g4b9b027469e82c76c4452bded1f32fc5fe955acbd53ad37db717721ce9eab920d1b5ca3abd81d55812613486a015a10b2c4e914e8b94296b2a974a4450076752_640.jpg", "https://pixabay.com/get/gd93f176c07f7ee9d336f024902a4193121bdc45f360da8731b6fd9d84d773409483efb31fff80e4b9569e9a0fce8cc5b0d4d68ff4de565e2cdd93629fb15be0d_640.jpg", "https://pixabay.com/get/g5523e2b0fafd99b3c15441296f647997c1079d439ef4954cb84198a58592762dc87e268c7b0d8bf62b22f3f4355c92d6283f9afa22ad8029294a0b11892dbb1c_640.jpg", "https://pixabay.com/get/g7fc0128e17d319d1944e0b547fe66b2ab2a6e6f91e48a0ef57680c7317863469f18f91504c7a6153974355b2890153f3308154a2200b4fd5c99235f17fb2af53_640.jpg", "https://pixabay.com/get/g57059dad018aeb24ebe786053dacacbea852aa2b1f8139537c762cc6d51b9bea18a1866fae224140344abc802709533b74c5555e413be310ecabb2504e651541_640.jpg", "https://pixabay.com/get/gbc510566a163ebeea0bc2a285c5dd79695f5de18d8b95020d05f0e34f44788ba658753f7593764320ec84fb45ea32b12_640.jpg", "https://pixabay.com/get/g7f16a9d60a7ed1e9edcfed44f089380e622de81b4d718a85e697a20a457f7d9604ceae27a885a38356f0b38c5cb91e66_640.jpg", "https://pixabay.com/get/g5adb8dc5bd413d1745ac51c1329d10b06ebe3b19981b61769a022e11e755e5f7d04787eab30210e005ad2b743c7310ab9f935309eb81deaa3bb63e114604d19d_640.jpg", "https://pixabay.com/get/geaa9f1fbf91563be28a17ec4e4f6711a282a48d84369d4ce84315ed2c335e5cc897d486e144728456d8aada084c44583cd1b5c5b04c0bf3968f0a8bbb0c6640e_640.jpg", "https://pixabay.com/get/g90088ccda5d8225124ad3826a5b0094409d7c50d53c948c5e0bbac4e1bb2dc23b3b9188cd3edf1cc6f44876f27cb55b3e6d6f1967ea51e985290bc0e96811f81_640.jpg", "https://pixabay.com/get/g21dcdaab66919b52a0f9e17f8680ca4cf2d0ef1d136ba1f992dda6ce60bb51dd310c2a182f2b73b6aa174d325ab8fbd5a809145e33fcdfeab464b6a03050e943_640.jpg", "https://pixabay.com/get/g4f4948f2b16487315bf27edc8f4898082f55948a0a85e985ad4c6957cc4a4da651f776e6bd2c1c60cf6b1b00a99736ce8089af7fdb8f919cfc1200fdd9a38c6e_640.jpg"]
    lazy var clickedImageUrl: String = "https://pixabay.com/get/g4f4948f2b16487315bf27edc8f4898082f55948a0a85e985ad4c6957cc4a4da651f776e6bd2c1c60cf6b1b00a99736ce8089af7fdb8f919cfc1200fdd9a38c6e_640.jpg"
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var mainImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainImage.sd_setImage(with: URL(string: clickedImageUrl))
        collectionView.delegate = self
        collectionView.dataSource = self
        let nib = UINib(nibName: "CustomImageCell", bundle: nil)
            collectionView.register(nib, forCellWithReuseIdentifier: CustomImageCell.identifier)
//        collectionView.reloadData()
    }
    
}

extension ImagePaigeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imagesArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomImageCell.identifier, for: indexPath) as? CustomImageCell else {
            fatalError("Could not dequeue CustomImageCell")
        }
        
        let imageURL = imagesArr[indexPath.row]
            print("Image URL: \(imageURL)")  // Print the image URL
            cell.imageView?.sd_setImage(with: URL(string: imageURL))
        
        return cell
    }
}


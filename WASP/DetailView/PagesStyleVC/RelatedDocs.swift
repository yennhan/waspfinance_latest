//
//  relatedDocs.swift
//  WASP
//
//  Created by Leow Yenn Han on 17/03/2019.
//  Copyright © 2019 wasp venture. All rights reserved.
//

import UIKit

class relatedDocs: UIViewController {
    
    let theDocType = ["Principal Terms and Conditions","Trust Deed","Information Memorandum","Annual Audited Accounts","Annual Audited Accounts","Periodic Financial Account","Periodic Financial Account","Periodic Financial Account"]
    let docName = ["Sunway Bhd - PTC.pdf","Sunway Bhd - TD.pdf","Sunway Bhd - IM.pdf","Sunway Berhad-AFS-311215.pdf","Sunway Berhad-AFS-311216.pdf","Sunway Berhad Q42015.pdf","Sunway Berhad Q12016.pdf","Sunway Berhad Q32016.pdf"]
    @IBOutlet weak var theCV: UICollectionView!
    var parentCV = DetailPageViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        theCV.delegate   = self
        theCV.dataSource = self
        // Do any additional setup after loading the view.
    }

}
extension relatedDocs: UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "docs", for: indexPath) as! RelatedDocsCollectionViewCell
        let theIndex = indexPath.row
        cell.theIndex.text = String(theIndex)
        cell.documentType.text = theDocType[indexPath.row]
        cell.docName.text = docName[indexPath.row]
        return cell
    }
    
    
}

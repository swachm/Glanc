//
//  findFriendsFromContacts.swift
//  
//
//  Created by Manmeet Swach on 2016-05-20.
//
//

import UIKit
import Contacts

class findFriendsFromContacts: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var contactList: UITableView!
    var contacts = [CNContact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveContacts()
        self.contactList.dataSource = self
        self.contactList.delegate = self
    }
    
//    override func viewDidAppear(animated: Bool) {
//        dispatch_async(dispatch_get_main_queue(), {() -> Void in
//            self.retrieveContacts()
//            self.contactList.reloadData()
//        })
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func popView(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: {});
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactsCell") as! contactTableViewCell
        
        let oneDataPoint = contacts[indexPath.row]
        cell.contactFullname.text = "\(oneDataPoint.givenName) \(oneDataPoint.familyName)"
        
        if oneDataPoint.imageDataAvailable{
            cell.userThumb.image = UIImage(data: oneDataPoint.imageData!)
        }else{
            cell.userThumb.image = UIImage(named: "me")
        }
        cell.userThumb.friendListImage()
        
//        if let phoneNumber = oneDataPoint.phoneNumbers[0]{
//            cell.phoneNumber.text = phoneNumber as! String
//        }else{
//            cell.phoneNumber.text = "N/A"
//        }
        cell.phoneNumber.text = "(333)-000-0000"
        return cell
    }
    
    func retrieveContacts(){
        let store = CNContactStore()
        let keysToFetch = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName), CNContactPhoneNumbersKey, CNContactThumbnailImageDataKey, CNContactImageDataAvailableKey, CNContactImageDataKey] as [Any]
        let request = CNContactFetchRequest(keysToFetch: keysToFetch as! [CNKeyDescriptor])
        
        do{
            _ = try store.enumerateContacts(with: request, usingBlock: { contact, cursor in
                let oneContact = contact as CNContact
                self.contacts.append(oneContact)
            })
        }catch {
            print("Error")
        }
        contactList.reloadData()
    }
}

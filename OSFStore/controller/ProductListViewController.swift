//
//  ProductListViewController.swift
//  OSFStore
//
//  Created by Ryan Chang on 14/11/23.
//  Copyright (c) 2014年 CandZen Co., Ltd. All rights reserved.
//

import UIKit

class ProductListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    var products: [Product] = []
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        println("viewDidLoad")
        
        // Don't call this when using storyboard
        // self.tableView.registerClass(ProductCell.self, forCellReuseIdentifier: "ProductCell")
    }
    
    override func viewWillAppear(animated: Bool) {
        getProducts()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showHUD() {
        //SVProgressHUD.showSuccessWithStatus("It works!")
        //SVProgressHUD.show()
        getProducts()
        getProduct(1)
    }
    
    func getProducts() -> [Product] {
        var products: [Product] = []
        let manager = AFHTTPRequestOperationManager()
        SVProgressHUD.show()
        manager.GET("http://addmenow.net:4000/api/products", parameters: nil, success: { (operation, responseObject: AnyObject!) -> Void in
            var error: NSError?
            if let json: NSArray = responseObject as? NSArray {
                // Use _stdlib_getDemangledTypeName to inspect the data type
                //println(_stdlib_getDemangledTypeName(json))
                
                for product in json {
                    if let p = product as? NSDictionary {
                        
                        if let id = p.valueForKey("id") as? Int {
                            println(id)
                            if let name = p.valueForKey("name") as? String {
                                println(name)
                                if let desc = p.valueForKey("desc") as? String {
                                    println(desc)
                                    if let price = p.valueForKey("price") as? Float {
                                        println(price)
                                        var product: Product = Product(id: id, name: name, desc: desc, price: price)
                                        products.append(product)
                                    }
                                }
                            }
                        }
                    }
                    //println(_stdlib_getemangledTypeName(product))
                }
                self.products = products
                self.tableView.reloadData()
            }
            }) { (operation, error) -> Void in
                println(error)
        }
        
        //SVProgressHUD.dismiss()
        return products
    }
    
    func getProduct(productId: Int) -> Product? {
        var error:  NSError?
        var product: Product?
        let manager = AFHTTPRequestOperationManager()
        manager.GET("http://addmenow.net:4000/api/products/\(productId)", parameters: nil, success: { (operation, responseObject) -> Void in
            println(responseObject)
            
            if let p: NSDictionary = responseObject as? NSDictionary {
                if let id = p.valueForKey("id") as? Int {
                    if let name = p.valueForKey("name") as? String {
                        if let desc = p.valueForKey("desc") as? String {
                            if let price = p.valueForKey("price") as? Float {
                                product = Product(id: id, name: name, desc: desc, price: price)
                            }
                        }
                    }
                }
            }
            
        }) { (operation, error) -> Void in
            println(error)
        }
        
        return product
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.products.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let product = products[indexPath.row]
        var cell: ProductCell? =
            tableView.dequeueReusableCellWithIdentifier("ProductCell")
            as? ProductCell
//        
//        if let optionalCell: ProductCell? = tableView.dequeueReusableCellWithIdentifier("ProductCell") as? ProductCell {
//            cell = optionalCell!
//        }
        println("cell: \(cell)")
        if cell == nil {
            println("create new cell")
            cell = ProductCell(style: UITableViewCellStyle.Default, reuseIdentifier: "ProductCell")
        }
        println("cell: \(cell)， product: \(product)， name: \(cell!.name.text)")
        cell!.name.text = product.name
        cell!.price.text = NSString(format: "%.2f", product.price)
        
//        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
//        let manager = AFURLSessionManager(sessionConfiguration: configuration)
//        let url = NSURL(string: "http://addmenow.net:4000/images/\(product.productId).jpg")
//        let request = NSURLRequest(URL: url!)
//        let downloadTask = manager.downloadTaskWithRequest(request, progress: nil, destination: { (targetPath, response) -> NSURL! in
//            let documentDirectoryURL = NSFileManager.defaultManager().URLForDirectory(NSSearchPathDirectory.DownloadsDirectory, inDomain: NSSearchPathDomainMask.UserDomainMask, appropriateForURL: nil, create: false, error: nil)
//            return documentDirectoryURL?.URLByAppendingPathComponent(response.suggestedFilename!)
//        }) { (response, filePath, error) -> Void in
//            println("downloaded to: \(filePath)")
//            let image = UIImage(data: NSData(contentsOfURL: filePath)!)
//            cell!.pic.image = image
//        }
//        
//        downloadTask.resume()
        
        let url = NSURL(string: "http://addmenow.net:4000/images/\(product.productId).jpg")
        let request = NSURLRequest(URL: url!)
        let placeholderImage = UIImage(named: "placeholder")
        cell?.pic.setImageWithURLRequest(request, placeholderImage: placeholderImage, success: { (request, response, image) -> Void in
            cell!.pic.image = image
        }, failure: { (request, response, error) -> Void in
            println(error)
        })
        return cell!
    }
}

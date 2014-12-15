//
//  ProductListViewController.swift
//  OSFStore
//
//  Created by Ryan Chang on 14/11/23.
//  Copyright (c) 2014年 CandZen Co., Ltd. All rights reserved.
//

import UIKit

class ProductListViewController: UIViewController {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        println("viewDidLoad")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showHUD() {
        SVProgressHUD.showSuccessWithStatus("It works!")
        getProducts()
        getProduct(1)
    }
    
    func getProducts() -> [Product] {
        var products: [Product] = []
        let manager = AFHTTPRequestOperationManager()
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
                    //println(_stdlib_getDemangledTypeName(product))
                }
            }
            }) { (operation, error) -> Void in
                println(error)
        }
        
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
}

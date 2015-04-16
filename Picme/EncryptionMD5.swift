//
//  EncryptionMD5.swift
//  Picme
//
//  Created by John Nguyen on 4/5/15.
//  Copyright (c) 2015 John Nguyen. All rights reserved.
//


import UIKit

    
    extension Int {
        func hexString() -> String {
            return NSString(format:"%02x", self) as String
        }
    }
    
    extension NSData {
        func hexString() -> String {
            var string = String()
            for i in UnsafeBufferPointer<UInt8>(start: UnsafeMutablePointer<UInt8>(bytes), count: length) {
                string += Int(i).hexString()
            }
            return string
        }
        
        func MD5() -> NSData {
            let result = NSMutableData(length: Int(CC_MD5_DIGEST_LENGTH))!
            CC_MD5(bytes, CC_LONG(length), UnsafeMutablePointer<UInt8>(result.mutableBytes))
            return NSData(data: result)
        }
        
        func SHA1() -> NSData {
            let result = NSMutableData(length: Int(CC_SHA1_DIGEST_LENGTH))!
            CC_SHA1(bytes, CC_LONG(length), UnsafeMutablePointer<UInt8>(result.mutableBytes))
            return NSData(data: result)
        }
    }
    
    extension String {
        func MD5() -> String {
            return (self as NSString).dataUsingEncoding(NSUTF8StringEncoding)!.MD5().hexString()
        }
        
        func SHA1() -> String {
            return (self as NSString).dataUsingEncoding(NSUTF8StringEncoding)!.SHA1().hexString()
        }
    }



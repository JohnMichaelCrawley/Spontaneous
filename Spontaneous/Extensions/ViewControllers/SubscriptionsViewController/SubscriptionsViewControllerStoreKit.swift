/*
 Project:           Spontaneous
 File:              SubscriptionViewControllerStoreKit.swift
 Created:           02/09/2023
 Author:            John Michael Crawley
 
 Description:
 This file handles all the Store Kit actions such as fetching,
 requesting or payment queue for the subscription
 */
// MARK: - Import List
import StoreKit
// MARK: - Subscription View Controller Extension
extension SubscriptionViewController: SKProductsRequestDelegate, SKPaymentTransactionObserver
{
    /*
     https://stackoverflow.com/questions/51489588/how-to-check-the-subscription-status-before-showing-the-first-view-in-swift
     https://stackoverflow.com/questions/73953272/storekit-2-how-to-verify-an-active-subscription
     https://www.delasign.com/blog/swift-storekit-subscription-status/
     
     */
    
    //MARK: - Fetch Products
    func fetchProducts()
    {
        let request = SKProductsRequest(productIdentifiers: Set(Product.allCases.compactMap({$0.rawValue})))
        request.delegate = self
        request.start()
    }
    //MARK: - Products Request - Did Recieve
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse)
    {
        DispatchQueue.main.async
        {
            self.subscriptionViewModel.subscriptionModels = response.products
        }
    }
    // MARK: - Payment Queue
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction])
    {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchased:
                // Handle the successful purchase, e.g., unlock content
                // Then, set the button title to "Cancel plan"
           //     setButtonTitleToCancelPlan()

                // Finish the transaction
                SKPaymentQueue.default().finishTransaction(transaction)

            case .failed: break
                // Handle the failed transaction, e.g., show an error message

            // Handle other transaction states as needed

            default:
                break
            }
        }
        
        /*
         transactions.forEach({
             switch $0.transactionState
             {
             case .purchasing:
                 print("Purchasing")
             case .purchased:
                 // Handle the successful purchase, e.g., unlock content
                 
                 print("Purchased")
                // SKPaymentQueue.default().finishTransaction($0)
             case .failed:
                 print("Failed")
               //  SKPaymentQueue.default().finishTransaction($0)
             case .restored:
                 print("Restored")
             case .deferred:
                 print("Deffeed")
             @unknown default:
                 print("Default")
             }
         })
         */
    }
}

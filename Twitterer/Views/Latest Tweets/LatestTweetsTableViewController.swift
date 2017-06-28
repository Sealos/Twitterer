//
//  Copyright © 2017 Stefano De Colli. All rights reserved.
//

import Foundation
import UIKit

/// Posible cells to be displayed
private enum CellType {
    case tweet(tweet: Tweet)
}

class LatestTweetsTableViewController: UITableViewController {

    private let service: TweetStreamingService

    // Serves as a list of the currently displayed tweets
    private(set) var queue = FixedSizeQueue<Tweet>(maxSize: Constants.Twitterer.amountOfTweets)

    /// Buffer to handle a tweets in case they arrive too quickly,
    /// allowing the user to read the tweets
    fileprivate(set) var buffer = Queue<Tweet>()

    private var rows = [CellType]()

    /// Timer used to refresh the include new tweets
    private var timer: Timer?

    private var header = LatestTweetHeader.instantiateFromNib()

    init(service: TweetStreamingService) {
        self.service = service

        #if UITEST
            let bundle = Bundle(for: TestableStreamingService.self)
        #else
            let bundle = Bundle.main
        #endif

        super.init(nibName: "LatestTweetsTableViewController", bundle: bundle)
    }

    required init?(coder aDecoder: NSCoder) {
        self.service = TwitterService()
        super.init(coder: aDecoder)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        service.delegate = self

        /// Registers the xibs
        tableView.register(TweetTableViewCell.self)

        service.startStreamingTweets()

        timer = Timer.scheduledTimer(withTimeInterval: Constants.Twitterer.secondsToRefreshTable, repeats: true, block: updateTable)

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80

        tableView.tableHeaderView = header

        navigationItem.title = "Twitterer"

        calculateRows()
        tableView.reloadData()
    }

    /// Map from Tweet to an internal CellType representation, in case we add more cells or sections
    private func calculateRows() {
        rows.removeAll(keepingCapacity: true)

        rows = queue.values.map { CellType.tweet(tweet:$0) }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row

        switch rows[row] {
        case .tweet(let tweet):
            let cell = tableView.dequeueReusableCell(for: indexPath) as TweetTableViewCell

            cell.customize(with: tweet)

            return cell
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return queue.values.count
    }

    /// Every time this function is executed (Runs with a timer), this will dequeue a tweet from the buffer,
    /// and enqueue it to the currently displayed tweets
    @objc private func updateTable(timer: Timer) {
        guard let unreadTweet = buffer.dequeue() else { return }

        queue.enqueue(unreadTweet)

        let countBefore = rows.count
        calculateRows()
        let countAfter = rows.count

        let shouldRemoveLastCell = countBefore == countAfter

        tableView.beginUpdates()

        let topIndexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [topIndexPath], with: .left)

        let lastIndexPath = IndexPath(row: rows.count - 1, section: 0)
        if shouldRemoveLastCell {
            tableView.deleteRows(at: [lastIndexPath], with: .right)
        }

        tableView.endUpdates()
    }
}

// MARK: - TweetStreamingServiceDelegate
extension LatestTweetsTableViewController: TweetStreamingServiceDelegate {
    func twitterService(didRecieveTweet tweet: Tweet) {
        buffer.enqueue(tweet)
    }

    func twitterService(didRecieveError error: Error) {
        let alert = UIAlertController(title: "Error", message: "Twitter is rate-limitting the account. Try again later", preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)

        alert.addAction(okAction)

        present(alert, animated: true)
    }
}

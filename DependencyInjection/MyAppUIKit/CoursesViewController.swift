//
//  CoursesViewController.swift
//  MyAppUIKit
//
//  Created by TCH Developer on 17/11/2022.
//

import UIKit
// We pass in the API Caller through this protocol
public protocol DataFetchable {
    func fetchCourseNames(completion: @escaping ([String]) -> Void)
}

struct Course {
    let name: String
}

public class CoursesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let dataFetchable: DataFetchable
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    public init(dataFetchable: DataFetchable) {
        self.dataFetchable = dataFetchable
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder: NSCoder) {
        fatalError()
    }
    
    var courses: [Course] = []
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        view.backgroundColor = .systemBackground
        // We don't want to cause ay memory leak which is why we capture out self in a weak capacity
        dataFetchable.fetchCourseNames { [weak self] names in
            self?.courses = names.map { Course(name: $0) }
            // Wrap table view in here so it occurs on the main view / thread.
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
            
        }
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = courses[indexPath.row].name
        return cell
    }

}

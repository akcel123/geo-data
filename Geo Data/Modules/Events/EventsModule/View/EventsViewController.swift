//
//  EventsViewController.swift
//  Geo Data
//
//  Created by Денис Павлов on 13.03.2023.
//

import UIKit

class EventsViewController: UIViewController {

    var presenter: EventsPresenterDelegate?
    // MARK: - private properties
    private let searchController = UISearchController(searchResultsController: nil)
    private var refreshControl = UIRefreshControl()
    
    private lazy var eventsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(EventsTableViewCell.self, forCellReuseIdentifier: EventsTableViewCell.reuseIdentifier)
        tableView.register(EventsTableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: EventsTableViewHeaderFooterView.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        
        return tableView
    }()
    
    
    
    //MARK: - life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        setupSearchBar()
        setupRefreshController()
        presenter?.updateEvents()
        setupSearchBar()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if presenter?.role == .user || presenter?.role == .none {
            presenter?.updateEventsTable(isChecked: true)
            return
        }
        
        presenter?.updateEventsTable(isChecked: presenter?.isChecked ?? false)

    }
    

}

// MARK: -  constraints
private extension EventsViewController {
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            eventsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            eventsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            eventsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            eventsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        ])
        
    }
}

//MARK: - setting views
private extension EventsViewController {
    func setupViews() {
        view.backgroundColor = .systemBackground
        self.title = "Список событий"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(eventsTableView)

    }
    
    func setupSearchBar() {
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
    }


}

// MARK: - HeaderTableViewDelegate
extension EventsViewController: HeaderTableViewDelegate {
    func actionForChecked() {
        presenter?.updateEventsTable(isChecked: true)
        presenter?.isChecked = true
        //print("action for checked")
    }
    func actionForNotChecked() {
        presenter?.updateEventsTable(isChecked: false)
        presenter?.isChecked = false
        //print("action for not checked")
    }
}

// MARK: - refresh controller
private extension EventsViewController {
    
    func setupRefreshController() {
        refreshControl.addTarget(self, action: #selector(updateTableWithNewData), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "Update")
        eventsTableView.refreshControl = refreshControl
    }
    
    //функция, вызывающаяся при рефреше (тянем таблицу вниз)
    @objc func updateTableWithNewData() {
        
        presenter?.updateEvents()
        self.refreshControl.endRefreshing()
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension EventsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getNumOfModelElements() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EventsTableViewCell.reuseIdentifier) as! EventsTableViewCell
        let (name, creationDate) : (String, String) = presenter?.getNameAndCreatDateWithIndex(indexPath.row) ?? ("" , "")
        var imageName = presenter?.getIconImageNameWithIndex(indexPath.row) ?? "UserEvent"

        
        
        cell.setupCellProp(name: name, creationDate: creationDate, image: imageName)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didTappedOnCell(with: indexPath.row)
    }
    
    // Данная функция определяет свайп влево по ячейке (кнопка справа).
    // В нашем случае добавил 2 кнопки: редактирование и цдаление
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // У пользоваткеля не должно быть такой возможности
        if  presenter?.role == .user {
            return nil
        }
        let swipeDelete = UIContextualAction(style: .destructive, title: nil) { (action, view, success) in
            self.presenter?.deleteEvent(with: indexPath.row)
            
        }
        swipeDelete.backgroundColor = .red
        swipeDelete.image = UIImage(systemName: "trash")
        
        
        let swipeEdit = UIContextualAction(style: .normal, title: nil) { action, view, success in
            self.presenter?.editEvent(with: indexPath.row)
            success(true)
        }
        swipeEdit.backgroundColor = UIElementsParameters.Color.semiMainColor
        swipeEdit.image = UIImage(systemName: "pencil")
        return UISwipeActionsConfiguration(actions: [swipeDelete, swipeEdit])
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if presenter?.role != .user, presenter?.role != .none {
            let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: EventsTableViewHeaderFooterView.reuseIdentifier) as? EventsTableViewHeaderFooterView
            presenter?.isChecked =  cell?.segmentedControl.selectedSegmentIndex != 0
            cell?.delegate = self
            return cell
        } else {
            return nil
        }
        
    }
        
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if presenter?.role != .user {
            return 56
        } else {
            return 0
        }
    }
    
}

// MARK: - EventsViewProtocol
extension EventsViewController: EventsViewPresenter {
    func refreshCollection() {
        eventsTableView.reloadData()
    }
}


// MARK: - UISearchBarDelegate
extension EventsViewController: UISearchBarDelegate {
    
    //Данный метод вызывается при заполнении searchBar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //TODO: Необходимо реализовать задержку перед поиском либо посмотреть другие решения
        
        print(searchText)
    }
}

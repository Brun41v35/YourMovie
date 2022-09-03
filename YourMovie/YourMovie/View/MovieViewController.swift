import UIKit
import Kingfisher

final class MovieViewController: UIViewController {
    
    //MARK: - Private Variables
    
    private let viewModel: ViewModelProtocol
    
    //MARK: - Init
    
    init(viewModel: ViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - IBOutlets
    
    @IBOutlet private weak var imageMovie: UIImageView!
    @IBOutlet private weak var nameMovie: UILabel!
    @IBOutlet private weak var labelViews: UILabel!
    @IBOutlet private weak var labelLikes: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    
    //MARK: - IBAction
    
    @IBAction func actionLike(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            sender.tintColor = UIColor.red
        } else {
            sender.tintColor = UIColor.white
        }
    }
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    //MARK: - setup
    
    private func setup() {
        setupTableView()
        setupLoadMovies()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupLoadMovies() {
        loadListMovies()
        loadMovieSelected()
    }
    
    //MARK: - Functions
    
    func loadListMovies() {
        viewModel.loadingMoviesAtList { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func loadMovieSelected(){
        
        viewModel.loagingMovieSelected { [weak self] movieSelected in
            guard let self = self else { return }
            guard let movieName = self.nameMovie else { return }
            guard let likesMovie = self.labelLikes else { return }
            guard let viewsMovie = self.labelViews else { return }
            
            DispatchQueue.main.async {
                movieName.text = movieSelected.title
                likesMovie.text = String(movieSelected.voteCount)
                viewsMovie.text = String(movieSelected.popularity)
                if let urlImage = URL(string: "https://image.tmdb.org/t/p/w300\(movieSelected.posterPath)") {
                    self.imageMovie.kf.setImage(with: urlImage)
                } else {
                    self.imageMovie.image = nil
                }
            }
        }
    }
}

// MARK: - Extension

extension MovieViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieTableViewCell
        let movie = viewModel.cellForRowAt(indexPath: indexPath)
        cell.prepareCell(with: movie)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone ? 100 : 260
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

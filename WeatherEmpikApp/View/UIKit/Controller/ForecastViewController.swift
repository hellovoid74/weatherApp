//
//  ViewController.swift
//  WeatherEmpikApp
//
//  Created by Gleb Lanin on 13/02/2023.
//

import UIKit
import Lottie

enum Section {
    case main
}

final class ForecastViewController: BaseViewController {
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section, WeatherForcast>
    var dataSource: DataSource!
    
    lazy var collectionView: UICollectionView = {
        let layout = FlowLayout.layout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(WeatherViewCell.self,
                                forCellWithReuseIdentifier:  WeatherCellConstants.id)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 200, height: 100)
        label.font = .systemFont(ofSize: 35, weight: .bold)
        label.backgroundColor = .clear
        label.textColor = .black
        label.minimumScaleFactor = 0.2
        label.numberOfLines = 1
        return label
    }()
    
    lazy var temperatureStack: UIStackView = {
        let hStack = UIStackView()
        hStack.axis = .horizontal
        hStack.distribution = .equalCentering
        hStack.alignment = .center
        hStack.spacing = 5
        return hStack
    }()
    
    lazy var sunStack: UIStackView = {
        let hStack = UIStackView()
        hStack.axis = .horizontal
        hStack.distribution = .equalCentering
        hStack.alignment = .center
        hStack.spacing = 40
        return hStack
    }()
    
    lazy var sunriseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var sunsetLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.minimumScaleFactor = 0.2
        label.font = .systemFont(ofSize: 50, weight: .semibold)
        label.backgroundColor = .clear
        return label
    }()
    
    lazy var temperatureIcon: UIImageView = {
        let image = ImageBundle.tempUI()
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .red
        return imageView
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.backgroundColor = .clear
        label.textColor = .darkText
        return label
    }()
    
    lazy var detailStack: UIStackView = {
        let hStack = UIStackView()
        hStack.axis = .horizontal
        hStack.distribution = .equalCentering
        hStack.alignment = .center
        hStack.spacing = 25
        return hStack
    }()
    
    lazy var windLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var pressureLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var rainLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    private var weatherArray: [WeatherForcast] = []
    private let viewModel: ItemViewModel
    private var animationView: LottieAnimationView?
    private var displayModel: WeatherModel?
    private var error: Error?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
    }
    
    init(viewModel: ItemViewModel) {
        self.viewModel = viewModel
        super.init()
        collectionView.dataSource = dataSource
        initialRequest()
    }
    
    private func initialRequest() {
        self.dataSource = makeDataSource()
        showProgress()
        viewModel.weatherRequest { [unowned self] result in
            switch result {
            case .success(let model):
                hideProgress()
                DispatchQueue.main.async {
                    self.displayModel = model
                    self.weatherArray = model.dailyForcast ?? []
                    self.createSnapshot()
                    self.configureUI()
                    self.fillWithData()
                }
            case .failure(let error):
                self.error = error
            }
        }
    }
    
    // MARK: - Create snapshot
    private func createSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, WeatherForcast>()
        snapshot.appendSections([.main])
        snapshot.appendItems(weatherArray)
        dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
    }
    
    // MARK: - Create UITableViewDiffableDataSource
    private func makeDataSource() -> DataSource {
        UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { [unowned self] tableView, indexPath, model -> UICollectionViewCell in
            guard let cell = self.collectionView.dequeueReusableCell(
                withReuseIdentifier: WeatherCellConstants.id,
                for: indexPath) as? WeatherViewCell else {
                return UICollectionViewCell()
            }
            
            cell.imageView.image = UIImage(systemName: model.conditionName)
            cell.imageView.tintColor = model.color
            cell.tempLabel.textColor = model.maxTemp.getUIColor()
            cell.minTempLabel.textColor = model.minTemp.getUIColor()
            cell.minTempLabel = cell.minTempLabel.addTextToLabel(
                string: model.minTemp.getTemperature(withSign: false),
                image: ImageBundle.tempUImin(), color: .systemBlue)
            cell.tempLabel = cell.tempLabel.addTextToLabel(
                string: model.maxTemp.getTemperature(withSign: false),
                image: ImageBundle.tempUImax(), color: .red)

            switch indexPath.row {
            case 0:
                cell.dayLabel.text = "Today"
            case 1:
                cell.dayLabel.text = "Tomorrow"
            default:
                cell.dayLabel.text = model.day.getWeekDay()
            }
            return cell
        })
    }
    
    private func fillWithData() {
        guard let model = displayModel else { return }
        
        cityLabel.text = model.cityName
        temperatureLabel.text = model.temperature.getTemperature(withSign: false)
        temperatureLabel.textColor = model.temperature.getUIColor()
        dateLabel.text = model.time
        sunriseLabel = sunriseLabel.addTextToLabel(
            string: model.sunrise.toString(),
            image: ImageBundle.sunriseUI(),
            color: .systemYellow
        )
        
        sunsetLabel = sunsetLabel.addTextToLabel(
            string: model.sunset.toString(),
            image: ImageBundle.sunsetUI(), color: .orange
        )
        
        windLabel = windLabel.addTextToLabel(
            string: model.windSpeed,
            image: ImageBundle.wind(),
            color: .systemIndigo)
        
        pressureLabel = pressureLabel.addTextToLabel(
            string: model.pressure,
            image: ImageBundle.pressure(),
            color: .systemIndigo)
        
        rainLabel = rainLabel.addTextToLabel(
            string: model.precipitation,
            image: ImageBundle.rainUI(),
            color: .systemIndigo
        )
    }
    
    private func configureUI() {
        view.addSubview(mainStackView)
        animationView = .init(name: displayModel?.animationName ?? "")
        let height = UIScreen.main.bounds.height
        
        if let animationView = animationView {
            mainStackView.addArrangedSubview(animationView)
            NSLayoutConstraint.activate([
                animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
                animationView.heightAnchor.constraint(equalToConstant: height / 5)
            ])

            animationView.play()
        }

        [temperatureIcon, temperatureLabel].forEach {
            temperatureStack.addArrangedSubview($0)
        }
        
        [sunriseLabel, sunsetLabel].forEach {
            sunStack.addArrangedSubview($0)
        }
        
        [windLabel, pressureLabel, rainLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            detailStack.addArrangedSubview($0)
        }
        
        [dateLabel, cityLabel, temperatureStack, sunStack, detailStack, collectionView].forEach {
            mainStackView.addArrangedSubview($0)
        }

        NSLayoutConstraint.activate([
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.widthAnchor.constraint(equalTo: view.widthAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 250)
        ])
        
        NSLayoutConstraint.activate([
            mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            temperatureIcon.widthAnchor.constraint(equalToConstant: 30),
            temperatureIcon.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


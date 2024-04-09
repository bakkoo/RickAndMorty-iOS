//
//  FilterView.swift
//  RickAndMorty
//
//  Created by Bakur Khalvashi on 30.03.24.
//

import SwiftUI

enum FilterType {
    case status
    case gender
}

class FilterOption: Identifiable, ObservableObject {
    let id = UUID()
    let name: String
    let image: String
    let type: FilterType
    @Published var selected: Bool
    
    init(name: String, image: String, selected: Bool = false, type: FilterType) {
        self.name = name
        self.image = image
        self.selected = selected
        self.type = type
    }
}

struct FilterView: View {
    @ObservedObject var filterViewModel = FilterViewModel()
    var onApplyFilter: (([FilterOption]) -> Void)
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            FilterSectionView(title: "Filter by status", options: $filterViewModel.statusOptions)
                .padding(.top)
            Divider()
                .padding()
            FilterSectionView(title: "Filter by gender", options: $filterViewModel.genderOptions)
            Divider()
                .padding()
            Spacer()
            HStack {
                Button(action: {
                    filterViewModel.applyFilters()
                }, label: {
                    Spacer()
                    Text("Done")
                        .frame(height: 40)
                    Spacer()
                })
                .tint(.blue)
                .buttonBorderShape(.roundedRectangle(radius: 15))
                .buttonStyle(.borderedProminent)
            }
            .padding(.horizontal)
        }
        .padding(.horizontal, 50)
    }
}

struct FilterSectionView: View {
    let title: String
    @Binding var options: [FilterOption]
    
    var body: some View {
        VStack(spacing: 10) {
            Text(title)
                .font(.title2)
                .padding(.top, 10)
            ForEach(options) { option in
                FilterItemView(option: option)
            }
        }
    }
}


struct FilterItemView: View {
    @ObservedObject var option: FilterOption
    private let feedbackGenerator = UISelectionFeedbackGenerator()
    
    var body: some View {
        Toggle(isOn: $option.selected) {
            HStack {
                Image(systemName: option.image)
                
                Text(option.name)
                
                Spacer()
                Image(systemName: option.selected
                      ? "checkmark.square.fill"
                      : "checkmark.square")
                .padding()
            }
            .frame(height: 40)
        }
        .tint(option.selected ? .blue : .gray)
        .toggleStyle(.button)
        .buttonStyle(.bordered)
        .buttonBorderShape(.roundedRectangle(radius: 15))
        .onChange(of: option.selected, { oldValue, newValue in
            feedbackGenerator.selectionChanged()
        })
    }
}

class FilterViewModel: ObservableObject {
    @Published var statusOptions: [FilterOption] = CharacterStatus
        .allCases
        .map { item in
            var image: String = ""
            switch item {
            case .alive:
                image = "heart.fill"
            case .dead:
                image = "xmark.circle.fill"
            case .unknown:
                image = "questionmark.circle.fill"
            }
            return FilterOption(name: item.rawValue, image: image, type: .status)
        }
    
    @Published var genderOptions: [FilterOption] = CharacterGender
        .allCases
        .map { item in
            var image = ""
            switch item {
            case .female:
                image = "person.circle.fill"
            case .genderless:
                image = "person.crop.circle.badge.questionmark.fill"
            case .male:
                image = "person.circle.fill"
            case .unknown:
                image = "questionmark.circle.fill"
            }
            return FilterOption(name: item.rawValue, image: image, type: .gender)
        }

    func applyFilters() {
        let selectedStatus = statusOptions.filter(\.selected).map(\.name)
        let selectedGender = genderOptions.filter(\.selected).map(\.name)
    }
}

#Preview {
    FilterView(onApplyFilter: {_ in})
}

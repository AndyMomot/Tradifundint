//
//  DefaultsService.swift
//
//  Created by Andrii Momot on 16.04.2024.
//

import Foundation

final class DefaultsService {
    static let standard = UserDefaults.standard
    private init() {}
}

extension DefaultsService {
    static var flow: RootContentView.ViewState {
        get {
            let name = standard.string(forKey: Keys.flow.rawValue) ?? ""
            return RootContentView.ViewState(rawValue: name) ?? .onboarding
        }
        set {
            standard.set(newValue.rawValue, forKey: Keys.flow.rawValue)
        }
    }
}

extension DefaultsService {
    static var projects: [AddProjectView.ProjectModel] {
        get {
            if let data = standard.object(forKey: Keys.projects.rawValue) as? Data {
                let items = try? JSONDecoder().decode([AddProjectView.ProjectModel].self, from: data)
                return items ?? []
            }
            return []
        }
        set {
            let items = newValue.sorted(by: { $0.dateCreated > $1.dateCreated })
            if let data = try? JSONEncoder().encode(items) {
                standard.setValue(data, forKey: Keys.projects.rawValue)
            }
        }
    }
    
    static func addProject(item: AddProjectView.ProjectModel) {
        var items = projects
        items.append(item)
        projects = items
    }
    
    static func deleteProject(item: AddProjectView.ProjectModel) {
        if let index = projects.firstIndex(where: {
            $0.id == item.id
        }) {
            var items = projects
            items.remove(at: index)
            projects = items
        }
    }
}

extension DefaultsService {
    static var isAllowedNotifications: Bool {
        get {
            standard.bool(forKey: Keys.notifications.rawValue)
        }
        set {
            standard.setValue(newValue, forKey: Keys.notifications.rawValue)
        }
    }
    
    static var batterySaving: Bool {
        get {
            standard.bool(forKey: Keys.battery.rawValue)
        }
        set {
            standard.setValue(newValue, forKey: Keys.battery.rawValue)
        }
    }
}

extension DefaultsService {
    static func removeAll() {
        if let bundleIdentifier = Bundle.main.bundleIdentifier {
            standard.removePersistentDomain(forName: bundleIdentifier)
        }
    }
}

// MARK: - Keys
extension DefaultsService {
    enum Keys: String {
        case flow
        case projects
        case notifications
        case battery
    }
}

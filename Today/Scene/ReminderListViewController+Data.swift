//
//  ReminderListViewController+Data.swift
//  Today
//
//  Created by Baris on 1.08.2023.
//

import UIKit


extension ReminderListViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, String>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, String>


    func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, id: Reminder.ID) {
        let reminder = Reminder.sampleData[indexPath.item]
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = reminder.title
        contentConfiguration.secondaryText = reminder.dueDate.dayAndTimeText
        contentConfiguration.secondaryTextProperties.font = UIFont.preferredFont(
                    forTextStyle: .caption1)
        cell.contentConfiguration = contentConfiguration
        
        var doneButtonConfiguration = doneButtonConfiguration(for: reminder)
            doneButtonConfiguration.tintColor = .todayListCellDoneButtonTint
        
        cell.accessories = [
                  .customView(configuration: doneButtonConfiguration), .disclosureIndicator(displayed: .always)
              ]
        
        var backgroundConfiguration = UIBackgroundConfiguration.listGroupedCell()
        backgroundConfiguration.backgroundColor = .todayListCellBackground
        cell.backgroundConfiguration = backgroundConfiguration
    }
    
    func reminder(withId id: Reminder.ID) -> Reminder {
           let index = reminders.indexOfReminder(withId: id)
           return reminders[index]
       }
    func updateReminder(_ reminder: Reminder) {
          let index = reminders.indexOfReminder(withId: reminder.id)
          reminders[index] = reminder
      }
    func completeReminder(withId id: Reminder.ID) {
        var reminder = reminder(withId: id)
        reminder.isComplete.toggle()
        updateReminder(reminder)
    }
    
    private func doneButtonConfiguration(for reminder: Reminder)
      -> UICellAccessory.CustomViewConfiguration
      {
          let symbolName = reminder.isComplete ? "circle.fill" : "circle"
          let symbolConfiguration = UIImage.SymbolConfiguration(textStyle: .title1)
          let image = UIImage(systemName: symbolName, withConfiguration: symbolConfiguration)
          let button = UIButton()
          button.setImage(image, for: .normal)
          return UICellAccessory.CustomViewConfiguration(
              customView: button, placement: .leading(displayed: .always))
      }
}

//
//  ScheduleViewController.swift
//  Helpy
//
//  Created by mac on 23/12/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import Foundation
protocol selectedTimeDelegate {
    func selectedTime(startTime: String, endTime: String, Date: String)
}

class ScheduleViewController: UIViewController {
    
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var calenderView: CalanderHeaderView!
    @IBOutlet weak var endTimeView: UIView!
    @IBOutlet weak var startTimeView: UIView!
    @IBOutlet weak var starttimeLabel: UILabel!
    @IBOutlet weak var endtimeLabel: UILabel!
    @IBOutlet weak var endtime: UILabel!
    @IBOutlet weak var stattime: UILabel!
    var selectedDate = Date()
    var delegate: selectedTimeDelegate?
    
    var FirstDate : Date?
    var SecondDate : Date? {
        didSet {
            self.endtime.text = SecondDate?.dateString("hh:mm a")
        }
    }
    
    var startTime = ""
    var endTime = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        Set_navigationBar(Title: "Schedule Date & Time", isneedback: true)
        selectedDate = Date()
        self.FirstDate = selectedDate
        calenderView.selectedDate = selectedDate
        calenderView.onClickSelectedData = { [weak self] (selectedDate) -> Void in
            self?.selectedDate = selectedDate
            self?.FirstDate = selectedDate
        }
    }
    
    override func viewDidLayoutSubviews() {
        startTimeView.roundCorners([.allCorners], radius: 10)
        endTimeView.roundCorners([.allCorners], radius: 10)
        btnNext.cornerRadius = btnNext.size.height / 2
    }
    
    func compareTime(starttime: Date, endtime: Date) -> Bool {
        return starttime.compare(endtime)  == .orderedAscending
    }
    
    @IBAction func NextButtonTapped(_ sender: UIButton) {
        let oneDayEarly = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        if FirstDate == nil || SecondDate == nil {
            self.view.makeToast("Please select date")
            return
        }
        if selectedDate <= oneDayEarly {
            self.view.makeToast("Please select today or next date")
            return
        } else {
            if stattime.text.asStringOrEmpty() == endtime.text.asStringOrEmpty() {
                self.view.makeToast("Please select different starttime and endtime ")
                return
            }
            if Calendar.current.isDateInToday(selectedDate) {
                if let selectedDate = FirstDate {
                    if selectedDate < Date() {
                        self.view.makeToast("Please select future Job Time")
                        return
                    }
                }
            }
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        let stringDate = dateFormatter.string(from: selectedDate)
        delegate?.selectedTime(startTime: stattime.text ?? "", endTime: endtime.text ?? "", Date: stringDate)
        navigationController?.popViewController(animated: true)
    }
    @IBAction func stattimeTapped(_ sender: UIControl) {
        
        RPicker.selectDate(title: "Select Time", cancelText: "Cancel",datePickerMode: .time,selectedDate: selectedDate, minDate: Date(), style: .Wheel, didSelectDate: {[weak self] (selectedDate) in
            self?.stattime.text = selectedDate.dateString("hh:mm a")
            self?.FirstDate = selectedDate
            
            if let secondDate = self?.SecondDate {
                if secondDate > selectedDate {
                    self?.SecondDate = selectedDate
                }
            } else {
                self?.SecondDate = selectedDate
            }
            
            if self?.stattime.text?.stringToDate() ?? Date() >= self?.endtime.text?.stringToDate() ?? Date(){
                self?.endtime.text = self?.stattime.text
            }else{
                if self?.endTime != ""{
                    self?.endtime.text = self?.endTime
                }
            }
        })
    }
    
    @IBAction func endtimeTapped(_ sender: UIControl) {
        let secoundDate = selectedDate.endOfDay
        RPicker.selectDate(title: "Selected Date", cancelText: "Cancel", doneText: "Done", datePickerMode: .time, selectedDate: selectedDate, minDate: FirstDate, maxDate: secoundDate, style: .Wheel) { (selectedDate) in
            self.SecondDate = selectedDate
        }
    }
    
}
extension Date {
    
    func dateString(_ format: String = "MMM-dd-YYYY, hh:mm a") -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        return dateFormatter.string(from: self)
    }
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
    var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }
}
extension String{
    func stringToDate() -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "hh:mm a"
        let date = dateFormatter.date(from:self)
        return date ?? Date()
    }
}

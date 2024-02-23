//
//  CalanderHeaderView.swift
//  Helpy
//
//  Created by mac on 30/12/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

//protocol CalanderButtonActionDelegate: AnyObject {
//    func PreviousButtonTapped()
//    func NextButtonTapped()
//}

class CalanderHeaderView: UIView {

    @IBOutlet weak var MonthView: UIView!
    @IBOutlet weak var CalanderBGView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var btnPrevious: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var MonthBG: UIView!
    @IBOutlet weak var lblMonth: UILabel!
    @IBOutlet weak var CalanderView: DateScrollPicker!
    
    
    private var format = DateScrollPickerFormat()
    var selectedDate = Date()
    var onClickSelectedData:((Date) -> ())?
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
        setupDate()
    }
    override func draw(_ rect: CGRect) {
       
    }
    @IBAction func btnPreviousTapped(_ sender: UIButton) {
        guard let previousMonth = Calendar.current.date(byAdding: .month, value: -1, to: selectedDate) else { return  }
        CalanderView.selectDate(previousMonth)
        dateScrollPicker(CalanderView, didSelectDate: previousMonth)
    }
    
    @IBAction func btnNextTapped(_ sender: UIButton) {
        guard let nextMonth = Calendar.current.date(byAdding: .month, value: 1, to: selectedDate) else { return  }
        dateScrollPicker(CalanderView, didSelectDate: nextMonth)
        CalanderView.selectDate(nextMonth)
    }
    private func commonInit() {
        let bundle = Bundle.main
        let nib = UINib(nibName: "CalanderHeaderView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as? UIView
        view?.frame = self.bounds
        view?.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        self.addSubview(view ?? UIView())
    }
    
    func setupDate() {
        format.days = 6
        format.topDateFormat = ""
        format.bottomDateFormat = "EEE"//“EEEE”
        format.topTextColor =  #colorLiteral(red: 0.5529411765, green: 0.5529411765, blue: 0.5529411765, alpha: 1)//UIColor.white.withAlphaComponent(!0.1)
        format.mediumTextColor = UIColor.black
        format.bottomTextColor = UIColor.App_Gray ?? UIColor()
        format.topFont = .systemFont(ofSize: 0)
        format.mediumFont = .systemFont(ofSize: 20)
        format.bottomFont = .systemFont(ofSize: 12)
        format.dayBackgroundColor = UIColor.App_Semibackground ?? UIColor()
        format.dayBackgroundSelectedColor = #colorLiteral(red: 0, green: 0.6941176471, blue: 0.9921568627, alpha: 1)
        format.separatorTopTextColor = UIColor.gray
        format.separatorBottomTextColor = UIColor.black
        format.separatorBackgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        format.separatorTopFont = .systemFont(ofSize: 12)
        format.separatorBottomFont = .systemFont(ofSize: 12)
        CalanderView.format = format
        CalanderView.delegate = self
        CalanderView.dataSource = self
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.CalanderView.selectDate(self.selectedDate)
            self.dateScrollPicker(self.CalanderView, didSelectDate: self.selectedDate)
            self.onClickSelectedData?(self.selectedDate)
        }
    }
    
    private func getMonthYear(_ date: Date = Date()){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        let nameOfMonth = dateFormatter.string(from: date)
        lblMonth.text = nameOfMonth
        print(nameOfMonth)
        getDateMonth(date)
    }
    private func getDateMonth(_ date: Date = Date()){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd"
        let nameofdate = dateFormatter.string(from: date)
        lblDate.text = nameofdate
        print(nameofdate)
    }
    
    
}
extension CalanderHeaderView: DateScrollPickerDelegate {
    
    func dateScrollPicker(_ dateScrollPicker: DateScrollPicker, didSelectDate date: Date) {
        getMonthYear(date)
        selectedDate = date
        onClickSelectedData?(date)
    }
}

extension CalanderHeaderView: DateScrollPickerDataSource {
    func dateScrollPicker(_ dateScrollPicker: DateScrollPicker, topAttributedStringByDate date: Date) -> NSAttributedString? {
        if Date.today() == date {
            return NSAttributedString(string: "Today")
        }
        else {
            return NSAttributedString(string: date.format(dateFormat: format.topDateFormat).capitalized)
        }
    }
    
    func dateScrollPicker(_ dateScrollPicker: DateScrollPicker, dotColorByDate date: Date) -> UIColor? {
        return .green
    }
}

module OrdersHelper
    def days_options
        days = (Date.today + 7)..(Date.today + 13)
        days = ["指定なし"] + days.map {|day| [day.strftime("%Y/%m/%d(#{localized_day_of_week(day)})"), day] }
    end

    def localized_day_of_week(day)
        %w[日 月 火 水 木 金 土][day.wday]
    end
end

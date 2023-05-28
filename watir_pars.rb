require 'watir'

module Parser

    def self.parser_search(photo)
        @browser = Watir::Browser.new :chrome, headless: true, options: {args: %w[--disable-blink-features=AutomationControlled]}
        @browser.goto('https://search4faces.com/vkok/index.html')

        @browser.button(id: "upload-button").wait_until( &:present? ).click 
        p @browser.button(class: "uppload-button uppload-button--cta").present?
        p @browser.file_field.exists?

        @browser.file_field.set("/home/vitamin/my_files/projects/Telegram_Bots/finder-bot2/bot/img/#{photo}.jpg")

        p @browser.element(class: "effects-continue--upload").wait_until( &:present? ).click

        loop do
            sleep 1
            if @browser.element(class: "uppload-loader").present?
                puts 'Loading...'
            elsif @browser.element(class: "uppload-error").present?
                puts 'Error!'
                @browser.close
                return "\u{1F615} Ошибка, попробуйте ещё раз через минуту или загрузите другое фото"         
            else 
                puts 'OK'
                sleep 2
                break
            end
        end

       @browser.button(id: "search-button").wait_until( &:present? ).click

        while @browser.element(class: "fa fa-spinner fa-spin").present? 
            sleep 1
            puts 'Searching...'
        end

        puts 'Done!'

        results1 = @browser.div(id: "search-results1").divs(class: "col-lg-3 col-md-4 col-xs-6")    
        
        items = nil
        info = nil
        name = nil
        percent = nil
        link = nil
        photo_url = nil

        if results1 != []
            results1.each do |item|
                items = item
                info = item.text.split("\n")        
                puts name = "Информация: #{info[2]}"        
                puts percent = "Процент сходства: #{info[1]}"       
                puts link = "Ссылка на соц. сеть #{info[0].gsub('00', '')}:  #{item.link.href}"     
                puts photo_url = 'Фото: ' + item.img.src        
                
            end      

            return "Информация: #{info[2]}\n\nПроцент сходства: #{info[1]}\n\nСсылка на соц. сеть #{info[0].gsub('00', '')}:  #{items.link.href}\n\nФото: #{items.img.src}\n"          
        else       
            return "Совпадений не найдено"
        end 
    end

    def self.close_browser
       @browser.close
    end

end


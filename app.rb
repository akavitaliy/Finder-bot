require 'down'
require 'telegram/bot'
require 'fileutils'
require_relative 'get_file.rb'
require_relative 'watir_pars.rb'

token = '5463297788:AAGvo83Ssah8YBO7h-wbgiIksJeGZ0U2XsE'

Telegram::Bot::Client.run(token) do |bot|
    bot.listen do |message|
        case message
        when '/start'
            bot.api.send_message(chat_id: message.from.id, text: "Загрузите фото размером не более 5 мб.")
        when Telegram::Bot::Types::Message 
            if message.photo != []             
                user_file(message, bot, token)
                bot.api.send_message(chat_id: message.from.id, text: "\u{1F50D} Идёт поиск\n\u{23F3} Это может занять несколько минут")                
                bot.api.send_message(chat_id: message.from.id, text: "#{Parser.parser_search(@user_photo_id)}") 
                Parser.close_browser
            else
                bot.api.send_message(chat_id: message.from.id, text: "\u{1F914} Вам нужно загрузить фото в формате jpg")
            end
        end
      end
end

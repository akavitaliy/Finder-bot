require 'down'

def user_file(message, bot, token)
    puts message.chat.type               
    if message.photo != []       
        puts @user_photo_id = message.photo.last.file_id
        p file = bot.api.get_file(file_id: @user_photo_id)
        p file_path = file.dig('result', 'file_path')
        p photo_url = "https://api.telegram.org/file/bot#{token}/#{file_path}"

        Down.download("#{photo_url.to_s}", destination: "img/#{@user_photo_id}.jpg")        
    end
end


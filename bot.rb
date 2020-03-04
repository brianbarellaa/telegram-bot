require 'telegram_bot'

token = '1136297398:AAEKKPU_f01jIa3ZIlvE7c1bka2a67uIPOA'

bot = TelegramBot.new(token: token)

bot.get_updates(fail_silently: true) do |message|
  puts "@#{message.from.username}: #{message.text}"
  command = message.get_command_for(bot)

  bot.listen do |message|
    case message
    when Telegram::Bot::Types::CallbackQuery
      # Here you can handle your callbacks from inline buttons
      if message.data == 'touch'
        bot.api.send_message(chat_id: message.from.id, text: "Don't touch me!")
      end
    when Telegram::Bot::Types::Message
      kb = [
        Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Go to Google', url: 'https://google.com'),
        Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Touch me', callback_data: 'touch'),
        Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Switch to inline', switch_inline_query: 'some text')
      ]
      markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)
      bot.api.send_message(chat_id: message.chat.id, text: 'Make a choice', reply_markup: markup)
    end
  end
end
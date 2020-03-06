require 'telegram_bot'
require 'mysql2/em'
require 'csv' 

token = '1136297398:AAEKKPU_f01jIa3ZIlvE7c1bka2a67uIPOA'

bot = TelegramBot.new(token: token)

CREATE TABLE `Assurance`.`"Monitor" + Date.now` (`No` INT NOT NULL AUTO_INCREMENT, `Tiket` TEXT(45), `Layanan` TEXT(45), `Progress` TEXT(45), `Pelanggan` TEXT(45), `Teknisi` TEXT(45), `DC` TEXT(45), `Connector` TEXT(45), `Adapter` TEXT(45), `Remote` TEXT(45), , `ONT` TEXT(45), `STB` TEXT(45));

@db_host  = "localhost"
@db_user  = "root"
@db_pass  = "whatever"
@db_name = "Assurance"

client = Mysql2::Client.new(:host => @db_host , :username => @db_user, :password => @db_pass, :database =>@db_name)

bot.get_updates(fail_silently: true) do |message|
  puts "@#{message.from.username}: #{message.text}"
  command = message.get_command_for(bot)

  message.reply do |reply|
    case command
    when /command1/i
      # Retrieve all rows from the persons table
      reply.text = "Download laporan berikut"
      results = client.query("SELECT * FROM Monitor")

    when /command2/i
      reply.text = "Hello, #{message.from.first_name}. 🤖"
    when /command3/i
      reply.text = "Jumlah Material : #{message.from.username}"
    when /command4/i
      # We insert some data using MySQL multi-row insert
      client.query("insert into Monitor(Tiket) values('Mark'), ('Osman'), ('Conan')")
    else
      reply.text = "I have no idea what #{command.inspect} means."
    end
    puts "sending #{reply.text.inspect} to @#{message.from.username}"
    reply.send_with(bot)
    
  end
end
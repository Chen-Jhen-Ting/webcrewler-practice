require 'sinatra'
require 'sinatra/reloader'
require 'nokogiri'
require 'open-uri'  # 標準函式庫

# 主程式
get "/" do
  doc = Nokogiri::HTML(URI.open('https://www.tenlong.com.tw/zh_tw/recent_bestselling?range=7'))

  @result = []

  doc.css('li.single-book').each do |book|
    title = book.css('.title a').text

    if title.include?("Git")
      title = "<strong>#{title}</strong>"
    end

    price = book.css('.pricing').text.split(" ").last

    @result << { title: title, price: price }
  end
  
  erb :index
end
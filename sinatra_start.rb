require 'sinatra'
get('/') do
  haml :index
end

post('/') do
  if params[:title] && params[:description]
    require 'rmagick'

    b = params[:description].scan(/[а-яa-zA-ZА-Я0-9_.,()—-]+/)
    second_text = ""
    b.each_with_index do |text, index|
      if index.modulo(4) == 3
        second_text += text + "\n"
      else
        second_text += text + " "
      end
    end

    img = Magick::ImageList.new("../1.jpg")

    title = Magick::Draw.new
    title.font = ''
    title.pointsize = 126
    title.font_weight = Magick::BoldWeight
    title.fill = 'white'
    title.gravity = Magick::CenterGravity
    title.annotate(img, 0, 0, 0, -400, params[:title])

    descritpion = Magick::Draw.new
    descritpion.font = ''
    if b.size > 20
      descritpion.pointsize = 48
    else
      descritpion.pointsize = 72
    end
    descritpion.font_weight = Magick::BoldWeight
    descritpion.fill = 'white'
    descritpion.gravity = Magick::CenterGravity
    descritpion.annotate(img, 0, 0, 0, 300, second_text)

    img.write("../actual_mem/#{params[:title]}.jpg")
  end

  haml :index
end

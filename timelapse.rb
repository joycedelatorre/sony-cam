puts "Smile! I'm taking your picture!"

require 'open-uri'
require 'httparty'
require 'json'

$pictures=[]
def take_picture(num_to_take, num_sleep)
  num_of_pictures = 0

  @urlstring_to_post = 'http://10.0.0.1:10000/sony/camera'

  @sound = HTTParty.post(@urlstring_to_post.to_str,
    :body => {
              :method => 'setBeepMode',
              :params => ['Off'],
              :id => 1,
              :version =>'1.0'
             }.to_json,
    :headers => {'Content-Type' => 'application/json'})

  while num_of_pictures < num_to_take do

    @result = HTTParty.post(@urlstring_to_post.to_str,
        :body => {
                  :method => 'actTakePicture',
                  :params => [],
                  :id => 1,
                  :version => '1.0'
                 }.to_json,
        :headers => {'Content-Type' => 'application/json'})

    @result["result"].each do |pic|
      filename_pic = pic[0].slice(/\bpict\d*\_\d*\.[A-Z]*/)
      open("pictures/" + filename_pic, 'wb') do |file|
          file << open(pic[0]).read
        end
    end

    num_of_pictures += 1
    sleep(num_sleep)
  end
end

take_picture(10,0) # as you take picture it will automatically download the image to the pictures directory.



puts "Hello World"

require 'open-uri'
require 'httparty'
require 'json'

$pictures=[]
def take_picture(num_to_take, num_sleep)
picture_container = []
  num_of_pictures = 0
  while num_of_pictures < num_to_take
    @urlstring_to_post = 'http://10.0.0.1:10000/sony/camera'

    @result = HTTParty.post(@urlstring_to_post.to_str,
        :body => {
                  :method => 'actTakePicture',
                  :params => [],
                  :id => 1,
                  :version => '1.0'
                 }.to_json,
        :headers => { 'Content-Type' => 'application/json' } )
    num_of_pictures += 1
    picture_container << @result["result"][0][0]
    sleep(num_sleep)
    #clean picture_container.
  end
  $pictures << picture_container
end

take_picture(2,0)

def download_pics()
  $pictures[0].each do |pic|
    filename_pic = pic.slice(/\bpict\d*\_\d*\.[A-Z]*/)
    open("pictures/" + filename_pic, 'wb') do |file|
      file << open(pic).read
      # p file
    end
  end
end
download_pics()

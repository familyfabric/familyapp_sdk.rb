Gem.post_install do
  Dir.pwd
  # if File.exist?('yatta.txt')
  #   p 1
  #   f= File.open('yatta.txt', 'r')
  #   p f.path
  # else
  #   p 2
  #   File.open('yatta.txt', 'w') { |f| f.write 'SUCC'}
  # end
end
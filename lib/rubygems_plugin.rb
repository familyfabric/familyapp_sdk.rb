Gem.post_install do
  if File.exists?('yatta.txt')
    File.open('yatta.txt', 'w') { |f| f.write 'SUCC'}
  else
    f= File.open('yatta.txt', 'r')
    p f.path
  end
end
Gem.post_install do
  if File.exists?('yatta.txt')
    File.open('yatta.txt', 'w') { |f| f.write 'SUCC'}
  else
    p "DUPA"
  end
end
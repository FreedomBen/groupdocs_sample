#!/usr/bin/env ruby

Dir.glob('*').each do |f|
  if f =~ /^output\\/
    File.rename(f, "output/#{f.gsub(/^output\\/, '')}")
  end
end

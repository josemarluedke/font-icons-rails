require 'net/http'

markers = ["\n/*autogenerated:BEGIN*/\n", "\n/*autogenerated:END*/\n"]
base_css = File.join( File.dirname( __FILE__ ), '..', 'vendor/assets/stylesheets', '_font-icons-entypo-remapped.scss' )
ie7_css = File.join( File.dirname( __FILE__ ), '..', 'vendor/assets/stylesheets', '_font-icons-entypo-remapped-ie7.css' )

original_svg_path = File.join( File.dirname( __FILE__ ), '..', 'vendor/assets/fonts', 'entypo.svg' )
remapped_svg_path = File.join( File.dirname( __FILE__ ), '..', 'vendor/assets/fonts', 'entyporemapped.svg' )
mapping_css_path = File.join( File.dirname( __FILE__ ), '..', 'vendor/assets/stylesheets', 'entypo-mapping.css' )

icons = File.read(mapping_css_path).gsub("\n",'').gsub("\t",'').scan(/\.icon-([a-z0-9\-]+):before.+?'.*?([A-Z0-9]+)/im)

svg = File.read( original_svg_path )
idx = 0
icons.each do |icon|
  print "#{icon[0]} => #{icon[1]}\n"
  idx += 1 if idx % 16 == 15
  idx += 1 if idx == 32
  hexcode = ("f%03X" % idx).downcase

  svg.gsub!(%{unicode="&#x#{icon[1].downcase};"}, %{unicode="&#x#{hexcode};"})
  icon[1] = hexcode

  idx += 1
end
File.open( remapped_svg_path, 'w' ){ |f| f.write svg }


payload = icons.map do |name, code|
  ".icon-et-#{name}:before".ljust(44) + "{ content: \"\\\\#{code.downcase}\"; }"
end.join("\n")
data = File.read(base_css).gsub(/#{Regexp.escape markers[0]}.+?#{Regexp.escape markers[1]}/im, markers[0] + payload + markers[1] )
File.open(base_css, 'w'){ |f| f.write data }
#print data

payload = icons.map do |name, code|
  ".icon-et-#{name}".ljust(32) + "{ *zoom: expression( this.runtimeStyle['zoom'] = \"1\", this.innerHTML = '&#x#{code.downcase};&nbsp;'); }"
end.join("\n")
data = File.read(ie7_css).gsub(/#{Regexp.escape markers[0]}.+?#{Regexp.escape markers[1]}/im, markers[0] + payload + markers[1] )
File.open(ie7_css, 'w'){ |f| f.write data }


print "\nNow go to http://www.freefontconverter.com/ to make TTF out of entyporemapped.svg\nThe put the TTF to http://www.fontsquirrel.com/fontface/generator with f000-f12e range.\n\n"

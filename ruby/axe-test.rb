require 'json'

def run_axe( original , url )
       j = IO.popen("pa11y -c pa11y.config.json --reporter json #{url}" ).read()
       data = JSON.parse(j)
       data.each do | line |
#         puts JSON.pretty_generate(line)
         print( "#{line['type']} " )
         print( "#{line['code']} " )
         print( "#{line['message']} \n" )
      end
end
       

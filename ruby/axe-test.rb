require 'json'
require './axe-modes'
require 'colorize'
require 'logger'

def run_axe( log , original , url , level )
       j = IO.popen("pa11y -c pa11y.config.json --reporter json #{url}" ).read()
       data = JSON.parse(j)
       print( "#{original} \n".green )
       data.each do | line |
       log.debug "Level : #{level} "
       # puts JSON.pretty_generate(line)
       if level >= Level::WARN or ( level == Level::ERROR and line['type'] == 'error' ) 
            print( "#{line['type']}: ".capitalize.red ) if line['type'] == 'error'
            print( "#{line['type']}: ".capitalize.yellow ) if line['type'] == 'warning'
            print( "#{line['message']} \n".bold )
            print( "#{line['context']} \n".white )
            print( "\n" )
       end

      end
end
       

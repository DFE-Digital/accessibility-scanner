require 'json'
require_relative 'a11y-modes'
require 'colorize'
require 'logger'

def run_a11y( log , original , url )
       status = false
       j = IO.popen("pa11y -c pa11y.config.json --reporter json #{url}" ).read()
       begin
          data = JSON.parse(j)
          puts( "#{original} \n".green )
          data.each do | line |
              status = true if line['type'] == 'error'
              #puts JSON.pretty_generate(line)
              level = line['type'].capitalize
              print( "#{ 0x2022.chr('UTF-8') } #{level}: ".red.bold ) if line['type'] == 'error'
              print( "#{ 0x2022.chr('UTF-8') } #{level}: ".yellow.bold ) if line['type'] != 'error'
              puts( "#{line['message']} ".bold )
              puts( "   #{line['code']} ".white )
              puts( "   #{line['selector']} ".white )
              puts( "   #{line['context']} ".white )
              puts( "" )
          end
       rescue StandardError => msg
          log.error msg 
          puts msg
       end
       return status
end
       

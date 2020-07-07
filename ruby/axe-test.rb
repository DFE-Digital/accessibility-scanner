require 'json'
require './axe-modes'
require 'colorize'
require 'logger'

def run_axe( log , original , url )
       j = IO.popen("pa11y -c pa11y.config.json --reporter json #{url}" ).read()
       data = JSON.parse(j)
       puts( "#{original} \n".green )
       data.each do | line |
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
end
       

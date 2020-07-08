require 'getoptlong'
require 'logger'
require 'syslog/logger'
require './a11y-process'
require './a11y-modes'


    @log = Syslog::Logger.new( 'a11y-crawl')
    @log.level = Logger::INFO
    mode = nil
    file = nil
    authenticate = false
    username = nil
    password = nil

   def usage
     puts <<~EOF
     Usage: a11y-crawl -s|f -U <username> -P <password> <file|url>
     Arguments:
        -s --sitemap  URL is a sitemap 
        -f --file  Passed in file is a line seperated list of URLs
        -U --username  Authentication Username
        -P --password  Authentication Password
        -v --verbose  Verbose Logging
        -h --help  Help and Usage
     EOF
     exit(1)
   end

    opts = GetoptLong.new(
          [ '--help'    , '-h', GetoptLong::NO_ARGUMENT ],
          [ '--sitemap' , '-s', GetoptLong::REQUIRED_ARGUMENT ],
          [ '--file'    , '-f', GetoptLong::REQUIRED_ARGUMENT ],
          [ '--username', '-U', GetoptLong::REQUIRED_ARGUMENT ],
          [ '--password', '-P', GetoptLong::REQUIRED_ARGUMENT ],
          [ '--verbose' , '-v', GetoptLong::NO_ARGUMENT ]
     )

     opts.each do |opt, arg|
        case opt
          when '--sitemap' 
            usage if mode 
            mode = Mode::SITEMAP 
            file = arg
          when '--file' 
            usage if mode 
            mode = Mode::FILE 
            file = arg
          when '--help'
            usage
          when '--verbose'
             @log.level = Logger::DEBUG
          when '--username'
             username = arg
             authenticate = true
          when '--password'
             password = arg
             authenticate = true
        end
     end

if not mode
    usage
end

b = AxeProcess.new( @log ,  mode , file , username , password )
status = b.analyze
exit( 1 ) if status == true 
exit( 0 )

require 'logger'
require './axe-modes'
require './axe-test'
require 'net/http'
require 'uri'
require 'openssl'
require 'nokogiri'


class AxeProcess
   @@mode = nil
   @@file = nil
   @@log  = nil
   @@files = []
   @@username = nil
   @@password = nil
   @@authentication = false

   def initialize( pLog , pMode , pFile , username , password )
      @@mode = pMode
      @@file = pFile
      @@log  = pLog
      @@log.debug "Mode : #{@@mode} File: #{@@file}"
      set_authentication( username , password ) if username
      process_file() if @@mode == Mode::FILE
      sitemap() if @@mode == Mode::SITEMAP
   end

   def set_authentication( username , password )
      @@log.debug "Using Authentication"
      @@username = username
      @@password = password
      @@authentication = true
   end

   def add_authentication( url )
      return url if @@authentication
      stripped_url = url.gsub( "https://" , "" )
      new_url  = "https://%s:%s@%s" % [ @@username , @@password , stripped_url ]
      return new_url
   end

   def analyze( level )
      @@files.each do | url | 
           uri = URI.parse( url )
           Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https', :verify_mode => OpenSSL::SSL::VERIFY_NONE) do |http|
               request = Net::HTTP::Get.new(uri.request_uri)
               request.basic_auth(@@username, @@password) if @@authentication
               response = http.request(request)
               @@log.error "#{response.code} Looking for website : #{url}" if response.code != '200'
               new_url = add_authentication( url )
               run_axe( @@log , url , new_url , level  ) if response.code == '200'
           end
      end
   end

   def process_file()
      @@log.debug "Reading File: #{@@file}"
      IO.readlines( @@file ).each do |line|
           @@log.debug "#{line.strip}"
           @@files << line.strip 
      end
   end

   def sitemap()
     uri = URI.parse(@@file)
     doc = nil

     Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https', :verify_mode => OpenSSL::SSL::VERIFY_NONE) do |http|
        request = Net::HTTP::Get.new(uri.request_uri)
        request.basic_auth(@@username, @@password) if @@authentication
        response = http.request(request)
        @@log.error "#{response.code} Looking for sitemap : #{@@file}" if response.code != '200'
        @@log.debug "#{response.code} Looking for sitemap : #{@@file}"
        doc = Nokogiri::XML( response.body )
        doc.remove_namespaces!
     end

     doc.xpath("//loc").each do |line|
        @@log.debug "#{line.text}"
        @@files << line.text 
     end
   end

end

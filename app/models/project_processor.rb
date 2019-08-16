require 'uri'
require 'net/http'

class ProjectProcessor
  def self.process!(project)
    res = fetch(project.url)

    # response = http.request(request)
    p project.url, res['X-Frame-Options']
    if res['X-Frame-Options']
      # don't want to kick off infinite loop
      project.update_column('can_frame', false)
    end
  end

  def self.process_all!
    Project.all.each do |project|
      begin
        process!(project)
      rescue
        project.update_column('can_frame', false)
      end
    end
  end

  def self.fetch(url, limit = 10)
    raise ArgumentError, 'HTTP redirect too deep' if limit == 0

    url = URI.parse(url)
    http = Net::HTTP.new(url.host, url.port)

    request = Net::HTTP::Get.new(url.request_uri)
    request["User-Agent"] = "New User Agent"
    request["Accept"] = "*/*"
    # http.verify_mode = OpenSSL::SSL::VERIFY_PEER
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    response = Net::HTTP.start(url.host, url.port, 
      :use_ssl => url.scheme == 'https') { |http| http.request request }

    case response
    when Net::HTTPSuccess     then response
    when Net::HTTPRedirection then fetch(response['location'], limit - 1)
    else
      response.error!
    end
  end
end
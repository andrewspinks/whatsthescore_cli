require 'net/http'
require 'json'

class Api

	def initialize
    @server = { host: '127.0.0.1', port: 3000 }
		@http = Net::HTTP.new(@server[:host], @server[:port])
    # @http = Net::HTTP.new(@server[:host], @server[:port], '127.0.0.1', 8888)
	end

	def create_game players
    req = Net::HTTP::Post.new('/games/create')
    req.content_type = 'application/json'
    puts players
    req.body = { players: players.inject([]) {|array, player| array << player[:name]  } }.to_json

    resp = @http.request req
    puts req.body
    @game_url = JSON.parse(resp.body, symbolize_names: true )[:url]
    puts @game_url
  end


  def score_team team
    req = Net::HTTP::Post.new(@game_url)
    req.content_type = 'application/json'
    req.body = { team: team }.to_json
    resp = @http.request req
    puts resp
    # JSON.parse(resp.body)[:url]
  end    
end
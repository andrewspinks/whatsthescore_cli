require 'net/http'
require 'json'
require 'pry'

class Api

	def initialize
    @server = { host: '127.0.0.1', port: 3000 }
		@http = Net::HTTP.new(@server[:host], @server[:port])
    # @http = Net::HTTP.new(@server[:host], @server[:port], '127.0.0.1', 8888)
	end

	def create_game players
    req = Net::HTTP::Post.new('/games/create')
    req.content_type = 'application/json'
    req.body = { players: players.inject([]) {|array, player| array << player[:name] } }.to_json

    resp = @http.request req
    game = JSON.parse(resp.body, symbolize_names: true )
    # puts game
    game
  end

  def score_team team
    # binding.pry
    req = Net::HTTP::Post.new(team[:score_url])
    req.content_type = 'application/json'
    # req.body = { team: team }.to_json
    resp = @http.request req
    # puts resp
    score = JSON.parse(resp.body, symbolize_names: true )
  end    
end
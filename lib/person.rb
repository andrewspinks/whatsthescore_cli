def create_player player_number
	player = {}
	player[:name] = ask "Player #{player_number} twitter handle"
	player[:beers_consumed] = ask("How many beers has #{player[:name]} consumed?") { |q| q.default = "0" }.to_i
	player
end
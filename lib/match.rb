
class Match

	def initialize game
    @game = game
    @api = Api.new
	end

  def play
    match_finished = false
    # `say 'game on mother fuckers'`

    until match_finished
      key = show_single_key

      winning_team = nil
      case key
      when "RIGHT ARROW"
        winning_team = :team_a
      when "LEFT ARROW"
        winning_team = :team_b
      end

      unless winning_team.nil?
        puts "#{winning_team} scored!"
        score = @api.score_team @game[winning_team]
        puts "Current score: #{score}"
      end
    end
  end

  def get_char
    @state ||= `stty -g`
    `stty raw -echo -icanon isig`
    begin
      char = STDIN.getc.chr
      if char == "\e"
        char = char + STDIN.getc.chr
        char = char + STDIN.getc.chr
      end
      char
    ensure
      `stty #{@state}`
    end
  end

  def show_single_key
    c = get_char
    case c
    when "\eOC"
      "RIGHT ARROW"
    when "\eOD"
      "LEFT ARROW"
    when /^.$/
      puts "SINGLE CHAR HIT: #{c.inspect}"
    else
      puts "SOMETHING ELSE: #{c.inspect}"
    end
  end
end
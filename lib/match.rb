
class Match

	def initialize api
    @api = api
	end

  def play
    match_finished = false
    # `say 'game on mother fuckers'`

    until match_finished
      key = show_single_key

      winning_team = ""
      case key
      when "RIGHT ARROW"
        winning_team = "team 2"
      when "LEFT ARROW"
        winning_team = "team 1"
      end

      unless winning_team.empty?
        puts "#{winning_team} scored!"
        score = @api.score_team winning_team
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
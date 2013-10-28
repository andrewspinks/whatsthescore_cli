
class Match

	def initialize game
    @game = game
    @api = Api.new
	end

  def play
    match_finished = false
    puts '----------------------------------'
    puts '--------- MATCH BEGIN ------------'
    `say --interactive=/green -v Trinoids "Game on!'"`
    puts 'Left arrow = score to team A'
    puts 'Right arrow = score to team B'
    puts '----------------------------------'

    until match_finished
      key = show_single_key

      winning_team = nil
      case key
      when "RIGHT ARROW"
        winning_team = :team_b
      when "LEFT ARROW"
        winning_team = :team_a
      end

      unless winning_team.nil?
        puts "#{winning_team} scored!"
        @score = @api.score_team @game[winning_team]
        puts "#{@score[:winning_team]} leads: #{@score[:score]}"
        match_finished = @score[:status] == 'Game over'
        unless @score[:encouragement].empty?
          `say --rate=300 -v Oliver "#{@score[:encouragement]}"`
        end
        @score[:instructions].each do |instruction|
          `say -v Oliver "#{instruction}"`
        end
      end
    end
    puts '----------------------------------'
    puts "-- MATCH COMPLETE - #{@score[:winning_team]} wins! --"
    puts '----------------------------------'
    `say -v 'Bad News' "Match complete - #{@score[:winning_team]} wins!"`
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
      # puts "SINGLE CHAR HIT: #{c.inspect}"
    else
      # puts "SOMETHING ELSE: #{c.inspect}"
    end
  end
end
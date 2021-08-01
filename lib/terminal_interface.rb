# frozen_string_literal: true

# TerminalInterface stores the methods used to display the game in the terminal
# It is broken into three methods to separate the title, board itself and player names
module TerminalInterface
  private

  def display_title
    puts <<~HEREDOC
      ----------------------------------------
      ------------- CONNECT FOUR -------------
      ----------------------------------------
    HEREDOC
  end

  def display_board
    t = game_board.board

    puts <<-HEREDOC
        |  #{t['1'][5]}  #{t['2'][5]}  #{t['3'][5]}  #{t['4'][5]}  #{t['5'][5]}  #{t['6'][5]}  #{t['7'][5]}   |
        |                        |
        |  #{t['1'][4]}  #{t['2'][4]}  #{t['3'][4]}  #{t['4'][4]}  #{t['5'][4]}  #{t['6'][4]}  #{t['7'][4]}   |
        |                        |
        |  #{t['1'][3]}  #{t['2'][3]}  #{t['3'][3]}  #{t['4'][3]}  #{t['5'][3]}  #{t['6'][3]}  #{t['7'][3]}   |
        |                        |
        |  #{t['1'][2]}  #{t['2'][2]}  #{t['3'][2]}  #{t['4'][2]}  #{t['5'][2]}  #{t['6'][2]}  #{t['7'][2]}   |
        |                        |
        |  #{t['1'][1]}  #{t['2'][1]}  #{t['3'][1]}  #{t['4'][1]}  #{t['5'][1]}  #{t['6'][1]}  #{t['7'][1]}   |
        |                        |
        |  #{t['1'][0]}  #{t['2'][0]}  #{t['3'][0]}  #{t['4'][0]}  #{t['5'][0]}  #{t['6'][0]}  #{t['7'][0]}   |
         ────────────────────────
           1  2  3  4  5  6  7
    HEREDOC
  end

  def display_players
    puts <<~HEREDOC
      ----------------------------------------
                     #{player_one.name}: #{player_one.symbol}
                     #{player_two.name}: #{player_two.symbol}
      ----------------------------------------
    HEREDOC
  end

  def display_game
    display_title
    display_board
    display_players
  end
end

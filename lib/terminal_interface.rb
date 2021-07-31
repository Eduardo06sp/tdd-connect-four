# frozen_string_literal: true

module TerminalInterface
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
      6 |  #{t['a6']}  #{t['b6']}   #{t['c6']}  #{t['d6']}  #{t['e6']}  #{t['f6']}  #{t['g6']}  |
        |                        |
      5 |  #{t['a5']}  #{t['b5']}   #{t['c5']}  #{t['d5']}  #{t['e5']}  #{t['f5']}  #{t['g5']}  |
        |                        |
      4 |  #{t['a4']}  #{t['b4']}   #{t['c4']}  #{t['d4']}  #{t['e4']}  #{t['f4']}  #{t['g4']}  |
        |                        |
      3 |  #{t['a3']}  #{t['b3']}   #{t['c3']}  #{t['d3']}  #{t['e3']}  #{t['f3']}  #{t['g3']}  |
        |                        |
      2 |  #{t['a2']}  #{t['b2']}   #{t['c2']}  #{t['d2']}  #{t['e2']}  #{t['f2']}  #{t['g2']}  |
        |                        |
      1 |  #{t['a1']}  #{t['b1']}   #{t['c1']}  #{t['d1']}  #{t['e1']}  #{t['f1']}  #{t['g1']}  |
         ────────────────────────
           A  B  C  D  E  F  G
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

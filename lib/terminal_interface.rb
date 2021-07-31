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
      6 |  #{t['A6']}  #{t['B6']}   #{t['C6']}  #{t['D6']}  #{t['E6']}  #{t['F6']}  #{t['G6']}  |
        |                        |
      5 |  #{t['A5']}  #{t['B5']}   #{t['C5']}  #{t['D5']}  #{t['E5']}  #{t['F5']}  #{t['G5']}  |
        |                        |
      4 |  #{t['A4']}  #{t['B4']}   #{t['C4']}  #{t['D4']}  #{t['E4']}  #{t['F4']}  #{t['G4']}  |
        |                        |
      3 |  #{t['A3']}  #{t['B3']}   #{t['C3']}  #{t['D3']}  #{t['E3']}  #{t['F3']}  #{t['G3']}  |
        |                        |
      2 |  #{t['A2']}  #{t['B2']}   #{t['C2']}  #{t['D2']}  #{t['E2']}  #{t['F2']}  #{t['G2']}  |
        |                        |
      1 |  #{t['A1']}  #{t['B1']}   #{t['C1']}  #{t['D1']}  #{t['E1']}  #{t['F1']}  #{t['G1']}  |
         ────────────────────────
           A  B  C  D  E  F  G
    HEREDOC
  end

  def display_players
  end

  def display_game
    display_title
    display_board
    display_players
  end
end

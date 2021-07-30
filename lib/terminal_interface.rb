# frozen_string_literal: true

module TerminalInterface
  def display_title
    puts <<~HEREDOC
      ----------------------------------------------------------------
      ------------------------- CONNECT FOUR -------------------------
      ----------------------------------------------------------------
    HEREDOC
  end

  def display_board
  end

  def display_game
  end
end

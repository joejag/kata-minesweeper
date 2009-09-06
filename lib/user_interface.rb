require 'optparse'

class UserInterface
  def initialize(command_line_args)
    cli_args_parser.parse!(command_line_args)
    
    unless @size
      puts cli_args_parser
      exit
    end
  end

  def start
    # Immediately quit: no other functionality required yet.
    print_revealed_board
  end

  private
  
  def cli_args_parser
    OptionParser.new do |opts|
      opts.accept(Array, /\[.*\]/) do |arg|
        eval(arg)
      end
      
      opts.on("--size=[width,height]", :REQUIRED, Array) do |size|
        @size = size
      end
      
      opts.on("--mines=[[x,y],[x',y'], ... ]", Array) do |mines|
        @mines = mines
      end
    end
  end

  def print_revealed_board
    @mines = [] if @mines.nil?
    proper_indexes = @mines.collect {|mine| [mine[0] - 1, mine[1] - 1] }

    ms = MineSweeper.new @size, proper_indexes
    ms.complete
    puts ms.draw_board
  end
end
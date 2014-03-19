require 'sinatra'
require 'rack-flash'
require 'sinatra/partial'
require_relative './lib/sudoku'
require_relative './lib/cell'
require_relative './helpers/application'

enable :sessions
set :session_secret, "I'm the secret key to sign the cookie"
use Rack::Flash
set :partial_template_engine, :erb

def random_sudoku
	seed = (1..9).to_a.shuffle + Array.new(81-9, 0)
	sudoku = Sudoku.new(seed.join)
	sudoku.solve!
	sudoku.to_s.chars
end

def puzzle(sudoku)
	sudoku.map {|x| rand(0..6) == 3 ? "0" : x  }
end


get '/' do
  prepare_to_check_solution
  generate_new_puzzle_if_necessary
  @current_solution = session[:current_solution] || session[:puzzle]
  @solution = session[:solution]
  @puzzle = session[:puzzle]
  erb :index
end

get '/solution' do
  @puzzle = session[:solution]
  erb :index
end

post '/' do
  cells = box_order_to_row_order(params["cell"])
  session[:current_solution] = cells.map{|value| value.to_i }.join
  session[:check_solution] = true
  redirect to("/")
end

get '/solution' do
  prepare_to_check_solution
  generate_new_puzzle_if_necessary
  @current_solution = session[:current_solution]
  @solution = session[:solution]
  @puzzle = session[:puzzle]
  erb :index
end

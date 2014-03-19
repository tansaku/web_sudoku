helpers do

  def colour_class(solution_to_check, puzzle_value, current_solution_value, solution_value)
    must_be_guessed = puzzle_value == 0
    guessed_incorrectly = current_solution_value != solution_value
    if guessed_incorrectly
      'incorrect'
    elsif !must_be_guessed
      'value-provided'
    end
  end

  def cell_value(value)
    value.to_i == 0 ? '' : value
  end

  def show_solution(value)
    value.to_i == 
  end

  def box_order_to_row_order(cells)
    boxes = cells.each_slice(9).to_a
    (0..8).to_a.inject([]) {|memo, i|
    first_box_index = i / 3 * 3
    three_boxes = boxes[first_box_index, 3]
    three_rows_of_three = three_boxes.map do |box| 
      row_number_in_a_box = i % 3
      first_cell_in_the_row_index = row_number_in_a_box * 3
      box[first_cell_in_the_row_index, 3]
    end
      memo += three_rows_of_three.flatten
    }
  end

  def generate_new_puzzle_if_necessary
    return if session[:current_solution]
    sudoku = random_sudoku
    session[:solution] = sudoku
    session[:puzzle] = puzzle(sudoku)
    session[:current_solution] = session[:puzzle]
  end

  def prepare_to_check_solution
    @check_solution = session[:check_solution]
    if @check_solution
      flash[:notice] = "Incorrect values are highlighted in yellow"
    end
    session[:check_solution] = nil
  end
end

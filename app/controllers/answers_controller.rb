class AnswersController < ApplicationController
  before_action :set_answer, only: [:show, :update, :destroy]

  def index
    @answers = Answer.all
    render json: @answers
  end

  def show
    render json: @answer
  end

  def create
    @answer = Answer.new(answer_params)

    if @answer.save
      render json: @answer, status: :created, location: @answer
    else
      render json: @answer.errors, status: :unprocessable_entity
    end
  end

  def update
    if @answer.update(answer_params)
      render json: @answer
    else
      render json: @answer.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @answer.destroy
    render json: { message: 'Answer deleted successfully' }, status: :ok
  end

  private

  def set_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:content, :formulary_id, :question_id, :visit_id, :answered_at)
  end
end

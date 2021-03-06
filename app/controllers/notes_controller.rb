# frozen_string_literal: true

class NotesController < OpenReadController
  before_action :set_note, only: %i[show update destroy]

  # GET /notes
  def index
    @notes = Note.all

    render json: @notes
  end

  def index_my_notes
    @notes = current_user.notes.all

    render json: @notes
  end

  # GET /notes/1
  def show
    # note = Note.find(params[:id])
    render json: @note
  end

  # POST /notes
  def create
    @note = current_user.notes.build(note_params)

    if @note.save
      render json: @note, status: :created, location: @note
    else
      render json: @note.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /notes/1
  def update
    if @note.update(note_params)
      render json: @note
    else
      render json: @note.errors, status: :unprocessable_entity
    end
  end

  # DELETE /notes/1
  def destroy
    @note.destroy

    head :no_content
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_note
    @note = current_user.notes.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def note_params
    params.require(:note).permit(:title, :date, :note_content, :user_id)
  end
end

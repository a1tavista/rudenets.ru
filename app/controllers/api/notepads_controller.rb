class Api::NotepadsController < Api::BaseController
  load_resource

  def index
    respond_with(@notepads)
  end

  def current
    @notepad = Notepad.current
    @notepad = Notepad.create(name: 'Новый блокнот') unless @notepad.present?
    render :show
  end

  def update
    @notepad.update(notepad_params)
  end

  private

  def notepad_params
    params.require(:notepad).except(:category, :is_current).permit(:id, :name, :text)
  end
end

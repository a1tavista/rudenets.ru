class Api::NotepadsController < Api::BaseController
  load_resource

  def index
    respond_with(@notepads)
  end

  def tree
    @notepads = Notepad.tree_hash
  end

  def current
    @notepad = Notepad.current
    @notepad = Notepad.create(name: 'Новый блокнот') unless @notepad.present?
    render :show
  end

  def create
    @notepad.text = ''
    @notepad.save
  end

  def update
    @notepad.update(notepad_params)
  end

  private

  def notepad_params
    params.require(:notepad).except(:category, :is_current).permit(:id, :name, :text, :ancestry)
  end
end
